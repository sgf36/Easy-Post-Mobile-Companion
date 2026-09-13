// The money screens, rendered against a fake proxy.
//
// Until the proxy client could be injected, no ordinary test could reach these
// screens at all, which is how a Reports total that counted refunded labels and
// an insurance Cost row that never rendered both shipped.
import 'dart:convert';

import 'package:easypost_mobile_companion/l10n/app_localizations.dart';
import 'package:easypost_mobile_companion/l10n/app_localizations_en.dart';
import 'package:easypost_mobile_companion/screens/claims_screen.dart';
import 'package:easypost_mobile_companion/screens/home_shell.dart';
import 'package:easypost_mobile_companion/screens/insurance_screen.dart';
import 'package:easypost_mobile_companion/screens/pickups_screen.dart';
import 'package:easypost_mobile_companion/screens/reports_screen.dart';
import 'package:easypost_mobile_companion/services/demo_fixtures.dart';
import 'package:easypost_mobile_companion/services/pairing_store.dart';
import 'package:easypost_mobile_companion/services/proxy_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';

const creds = PairingCredentials(
  deviceToken: 'dev',
  kek: 'kek',
  proxyUrl: 'https://proxy.test',
);

final nav = AppNav(
  current: Section.reports,
  onSelect: (_) {},
  onUnpair: () async {},
);

final en = AppLocalizationsEn();

/// Answers each collection with [collections], one page, and records POSTs.
ProxyClient fakeProxy(
  Map<String, List<Map<String, dynamic>>> collections, {
  List<http.Request>? posts,
}) => ProxyClient(
  httpClient: MockClient((req) async {
    if (req.method == 'POST') {
      posts?.add(req);
      return http.Response('{}', 200);
    }
    final name = req.url.pathSegments.last;
    return http.Response(
      jsonEncode({name: collections[name] ?? const [], 'has_more': false}),
      200,
    );
  }),
);

Future<void> pump(WidgetTester tester, Widget screen) async {
  tester.view.physicalSize = const Size(1170, 2532);
  tester.view.devicePixelRatio = 3.0;
  addTearDown(tester.view.reset);
  await tester.pumpWidget(
    MaterialApp(
      locale: const Locale('en'),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: screen,
    ),
  );
  await tester.pumpAndSettle();
}

void main() {
  testWidgets(
    'Reports: refunded labels are not spend, pending refunds shown apart',
    (tester) async {
      await pump(
        tester,
        ReportsScreen(
          nav: nav,
          creds: creds,
          proxy: fakeProxy({'shipments': demoShipments}),
        ),
      );

      expect(find.textContaining('67.75 GBP'), findsOneWidget);
      expect(find.textContaining('71.90'), findsNothing);
      expect(find.text(en.reportsRefundsPending), findsOneWidget);
      expect(find.text('9.80 USD'), findsOneWidget);
      // Ten bought labels that still count; the refunded one is gone.
      expect(find.text('10'), findsOneWidget);
    },
  );

  testWidgets(
    'Insurance: status has words and the Cost row renders from the Fee',
    (tester) async {
      await pump(
        tester,
        InsuranceScreen(
          nav: nav,
          creds: creds,
          proxy: fakeProxy({'insurances': demoInsurances}),
        ),
      );
      await tester.tap(find.text('EZ2000000002'));
      await tester.pumpAndSettle();

      expect(find.text(en.insuranceStatusPurchased), findsOneWidget);
      expect(find.text(en.statusUnknown), findsNothing);
      expect(find.text(en.fieldCost.toUpperCase()), findsOneWidget);
      expect(find.text('1.20 USD'), findsOneWidget);
    },
  );

  testWidgets('Claims: statuses have words, and no currency is invented', (
    tester,
  ) async {
    await pump(
      tester,
      ClaimsScreen(
        nav: nav,
        creds: creds,
        proxy: fakeProxy({
          'claims': [
            {
              'id': 'clm_1',
              'tracking_code': 'EZCLAIM1',
              'status': 'approved_partial',
              'type': 'damage',
              'requested_amount': '64.00',
            },
          ],
        }),
      ),
    );
    expect(find.text(en.claimStatusApprovedPartial), findsOneWidget);
    expect(find.text(en.statusUnknown), findsNothing);

    await tester.tap(find.text('EZCLAIM1'));
    await tester.pumpAndSettle();
    expect(
      find.text('64.00'),
      findsOneWidget,
      reason: 'the Claim object names no currency, so none is printed',
    );
    expect(find.textContaining('USD'), findsNothing);
  });

  testWidgets(
    'Pickups: a scheduled pickup reads "Scheduled" and can be cancelled',
    (tester) async {
      final posts = <http.Request>[];
      await pump(
        tester,
        PickupsScreen(
          nav: nav,
          creds: creds,
          proxy: fakeProxy({
            'pickups': [
              ...demoPickups,
              {'id': 'pck_old', 'status': 'canceled'},
            ],
          }, posts: posts),
        ),
      );

      expect(find.textContaining(en.pickupStatusScheduled), findsOneWidget);
      expect(find.textContaining(en.pickupStatusCanceled), findsOneWidget);
      expect(find.text(en.statusUnknown), findsNothing);
      // Only the scheduled one offers Cancel.
      expect(find.widgetWithText(TextButton, en.actionCancel), findsOneWidget);

      await tester.tap(find.widgetWithText(TextButton, en.actionCancel));
      await tester.pumpAndSettle();
      await tester.tap(
        find.widgetWithText(FilledButton, en.pickupCancelConfirm),
      );
      await tester.pumpAndSettle();

      expect(posts.map((r) => r.url.path), ['/ep/pickups/pck_demo_01/cancel']);
      expect(find.text(en.pickupCancelDone), findsOneWidget);
    },
  );
}
