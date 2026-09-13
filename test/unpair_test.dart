// Unpairing must revoke the phone's access at the proxy, not only forget it.
//
// 1.3.0 deleted the keychain entries and nothing else, so the device token kept
// working for ever while the App Store listing said unpairing revoked access.
// These tests drive the real ProxyClient against a fake network and the real
// PairingStore against flutter_secure_storage's in-memory test platform.
import 'dart:io';

import 'package:easypost_mobile_companion/l10n/app_localizations_en.dart';
import 'package:easypost_mobile_companion/main.dart';
import 'package:easypost_mobile_companion/services/pairing_store.dart';
import 'package:easypost_mobile_companion/services/proxy_client.dart';
import 'package:easypost_mobile_companion/services/review_prompt.dart';
import 'package:easypost_mobile_companion/services/unpair.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:shared_preferences/shared_preferences.dart';

const proxyUrl = 'https://proxy.test';

const creds = PairingCredentials(
  deviceToken: 'dev-token-1',
  kek: 'kek-1',
  proxyUrl: proxyUrl,
);

/// A fake proxy that records every request and answers with [respond].
class FakeProxy {
  final List<http.Request> requests = [];
  Future<http.Response> Function(http.Request) respond;

  FakeProxy(this.respond);

  late final MockClient client = MockClient((req) async {
    requests.add(req);
    return respond(req);
  });

  List<http.Request> get revokes =>
      requests.where((r) => r.url.path == '/pair/revoke').toList();
}

Future<http.Response> ok(http.Request _) async =>
    http.Response('{"ok":true}', 200);
Future<http.Response> offline(http.Request _) async =>
    throw const SocketException('Failed host lookup');

void main() {
  setUp(() {
    FlutterSecureStorage.setMockInitialValues({});
    SharedPreferences.setMockInitialValues({});
  });

  group('Unpairer', () {
    test(
      'revokes with the device token alone, then clears the keychain',
      () async {
        final proxy = FakeProxy(ok);
        final store = PairingStore();
        await store.save(creds);

        final outcome = await Unpairer(
          store: store,
          proxy: ProxyClient(httpClient: proxy.client),
        ).unpair(creds);

        expect(outcome, UnpairOutcome.revoked);
        expect(proxy.revokes, hasLength(1));
        final req = proxy.revokes.single;
        expect(req.method, 'POST');
        expect(req.url.toString(), '$proxyUrl/pair/revoke');
        expect(req.headers['authorization'], 'Bearer dev-token-1');
        expect(
          req.headers.containsKey('x-ep-kek'),
          isFalse,
          reason:
              'revoking needs only the token; the KEK never leaves for this',
        );
        expect(await store.load(), isNull);
        expect(await store.pendingRevokes(), isEmpty);
      },
    );

    test('offline: still unpairs locally and keeps the token queued', () async {
      final proxy = FakeProxy(offline);
      final store = PairingStore();
      await store.save(creds);
      final unpairer = Unpairer(
        store: store,
        proxy: ProxyClient(httpClient: proxy.client),
      );

      expect(await unpairer.unpair(creds), UnpairOutcome.revokeQueued);
      expect(
        await store.load(),
        isNull,
        reason: 'a dead network must not leave the user paired',
      );
      final pending = await store.pendingRevokes();
      expect(pending.map((p) => p.deviceToken), ['dev-token-1']);
      expect(pending.single.proxyUrl, proxyUrl);

      // Back online: the next launch or resume finishes the job.
      proxy.respond = ok;
      expect(await unpairer.retryPending(), 0);
      expect(await store.pendingRevokes(), isEmpty);
      expect(proxy.revokes.last.headers['authorization'], 'Bearer dev-token-1');
    });

    test('a server error is not a revoke; it stays queued', () async {
      final proxy = FakeProxy((_) async => http.Response('oops', 503));
      final store = PairingStore();
      final unpairer = Unpairer(
        store: store,
        proxy: ProxyClient(httpClient: proxy.client),
      );

      expect(await unpairer.unpair(creds), UnpairOutcome.revokeQueued);
      expect(await unpairer.retryPending(), 1);
      expect(await store.pendingRevokes(), hasLength(1));
    });

    test(
      '401 means the proxy already refuses the token, which is done',
      () async {
        final proxy = FakeProxy((_) async => http.Response('{}', 401));
        final store = PairingStore();

        expect(
          await Unpairer(
            store: store,
            proxy: ProxyClient(httpClient: proxy.client),
          ).unpair(creds),
          UnpairOutcome.revoked,
        );
        expect(await store.pendingRevokes(), isEmpty);
      },
    );

    test('idempotent: unpairing the same token twice queues it once', () async {
      final proxy = FakeProxy(offline);
      final store = PairingStore();
      final unpairer = Unpairer(
        store: store,
        proxy: ProxyClient(httpClient: proxy.client),
      );

      await unpairer.unpair(creds);
      await unpairer.unpair(creds);
      expect(await store.pendingRevokes(), hasLength(1));

      proxy.respond = ok;
      await unpairer.retryPending();
      await unpairer.retryPending();
      expect(await store.pendingRevokes(), isEmpty);
    });

    test(
      'a new pairing does not disturb a revoke still owed for the old one',
      () async {
        final proxy = FakeProxy(offline);
        final store = PairingStore();
        final unpairer = Unpairer(
          store: store,
          proxy: ProxyClient(httpClient: proxy.client),
        );
        await unpairer.unpair(creds);

        const next = PairingCredentials(
          deviceToken: 'dev-token-2',
          kek: 'kek-2',
          proxyUrl: proxyUrl,
        );
        await store.save(next);
        expect((await store.load())?.deviceToken, 'dev-token-2');
        expect((await store.pendingRevokes()).map((p) => p.deviceToken), [
          'dev-token-1',
        ]);
      },
    );
  });

  group('the app', () {
    Future<void> pumpApp(WidgetTester tester, FakeProxy proxy) async {
      await tester.pumpWidget(
        CompanionApp(
          reviewPrompt: FakeReviewPrompt(),
          proxy: ProxyClient(httpClient: proxy.client),
        ),
      );
      await tester.pumpAndSettle();
    }

    testWidgets('a 401 replaces every section with one "Pair again" screen', (
      tester,
    ) async {
      FlutterSecureStorage.setMockInitialValues({
        'device_token': creds.deviceToken,
        'kek': creds.kek,
        'proxy_url': creds.proxyUrl,
      });
      final proxy = FakeProxy(
        (req) async => req.url.path.startsWith('/ep/')
            ? http.Response('{"error":"unauthenticated"}', 401)
            : http.Response('{"ok":true}', 200),
      );

      await pumpApp(tester, proxy);

      final en = AppLocalizationsEn();
      expect(find.text(en.pairingLostTitle), findsOneWidget);
      expect(
        find.text(en.errorNotPaired),
        findsNothing,
        reason: 'the dead-end error text is what this screen replaces',
      );
      expect(
        find.widgetWithText(FilledButton, en.pairingLostAction),
        findsOneWidget,
      );

      // "Pair again" still revokes: a 401 can mean a KEK mismatch while the
      // token itself is live.
      await tester.tap(find.widgetWithText(FilledButton, en.pairingLostAction));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 50));
      expect(proxy.revokes, hasLength(1));
      expect(
        proxy.revokes.single.headers['authorization'],
        'Bearer dev-token-1',
      );
      expect(find.text(en.pairingLostTitle), findsNothing);
      expect(await tester.runAsync(() => PairingStore().load()), isNull);
    });

    testWidgets('Unpair from the drawer while offline says revoke is pending', (
      tester,
    ) async {
      FlutterSecureStorage.setMockInitialValues({
        'device_token': creds.deviceToken,
        'kek': creds.kek,
        'proxy_url': creds.proxyUrl,
      });
      final proxy = FakeProxy((req) async {
        if (req.url.path == '/pair/revoke') {
          throw const SocketException('offline');
        }
        return http.Response(
          '{"trackers":[],"shipments":[],"has_more":false}',
          200,
        );
      });

      await pumpApp(tester, proxy);
      final en = AppLocalizationsEn();

      tester.firstState<ScaffoldState>(find.byType(Scaffold)).openDrawer();
      await tester.pumpAndSettle();
      await tester.tap(find.text(en.drawerUnpair));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 50));

      expect(proxy.revokes, hasLength(1));
      expect(find.text(en.unpairRevokeQueued), findsOneWidget);
      expect(
        (await tester.runAsync(
          () => PairingStore().pendingRevokes(),
        ))!.map((p) => p.deviceToken),
        ['dev-token-1'],
      );
    });
  });
}
