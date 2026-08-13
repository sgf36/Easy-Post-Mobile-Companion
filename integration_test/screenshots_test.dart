// Drives the app through the App Store shot list from CAPTURE-IOS-SCREENSHOTS.md.
//
// Taps happen in-process against the widget tree, so this needs no macOS
// accessibility permissions. At each clean frame it calls the host-side
// shotserver, which takes the native 1320x2868 capture with `xcrun simctl`.
//
// The reviewer code is redeemed directly and the credentials seeded before
// `main()` runs, so `RootGate` opens on Tracking and `PairScreen` -- and with it
// the QR scanner -- is never built. In the simulator the scanner would raise an
// iOS camera-permission alert that sits on top of every capture, and the doc
// does not want the pairing screen in the store listing anyway.
//
// Capture tooling only -- not part of the shipped app or its test suite.
//
// Usage, against a booted 6.9-inch simulator (iPhone 16 or 17 Pro Max):
//
//   python3 tool/shotserver.py &
//   flutter test integration_test/screenshots_test.dart -d "iPhone 16 Pro Max"
//
// The PNGs land in ~/Desktop/asc-screenshots at 1320x2868.
import 'package:easypost_mobile_companion/config.dart';
import 'package:easypost_mobile_companion/main.dart' as app;
import 'package:easypost_mobile_companion/services/pairing_store.dart';
import 'package:easypost_mobile_companion/services/proxy_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:integration_test/integration_test.dart';

const String _reviewCode = 'epmc-demo-7f3a9c2e';
const String _shotServer = 'http://127.0.0.1:8099';

/// Lets real async work (network, map tiles) run, then pumps frames so the
/// result is on screen. `pumpAndSettle` is avoided where the map or a progress
/// indicator would never reach a settled state.
Future<void> _settle(WidgetTester tester,
    {int seconds = 3, int frames = 12}) async {
  await tester.runAsync(() => Future<void>.delayed(Duration(seconds: seconds)));
  for (var i = 0; i < frames; i++) {
    await tester.pump(const Duration(milliseconds: 150));
  }
}

/// Set SHOTS_REQUIRED=1 (CI does) to turn a failed capture into a failed test.
///
/// Left off, this helper swallows its own errors so one bad screen cannot cost
/// the remaining shots — reasonable when a human is watching the simulator. In
/// CI nobody is watching, and a run where the shot server was never started
/// captured nothing at all yet still reported success. Unattended runs must
/// fail loudly instead.
const bool _shotsRequired =
    bool.fromEnvironment('SHOTS_REQUIRED', defaultValue: false);

Future<void> _shot(WidgetTester tester, String name) async {
  await _settle(tester, seconds: 1, frames: 6);
  Object? failure;
  await tester.runAsync(() async {
    try {
      final response = await http
          .get(Uri.parse('$_shotServer/shot?name=$name'))
          .timeout(const Duration(seconds: 30));
      if (response.statusCode != 200) {
        throw StateError(
            'shot server returned ${response.statusCode}: ${response.body}');
      }
      debugPrint('STEP shot-ok $name');
    } catch (e) {
      debugPrint('STEP shot-fail $name $e');
      failure = e;
    }
  });
  if (failure != null && _shotsRequired) {
    fail('Screenshot "$name" was not captured: $failure');
  }
}

/// Runs one capture step, logging rather than aborting the whole run so a
/// single bad screen cannot cost us the remaining shots.
Future<void> _step(String name, Future<void> Function() body) async {
  debugPrint('STEP begin $name');
  try {
    await body();
    debugPrint('STEP done $name');
  } catch (e, st) {
    debugPrint('STEP error $name: $e');
    debugPrint('$st');
  }
}

/// Opens the nav drawer from the current section and taps [section].
Future<void> _drawerTo(WidgetTester tester, String section) async {
  final Finder menu = find.byTooltip('Open navigation menu');
  if (menu.evaluate().isNotEmpty) {
    await tester.tap(menu.first);
  } else {
    final ScaffoldState scaffold = tester.firstState(find.byType(Scaffold));
    scaffold.openDrawer();
  }
  await tester.pumpAndSettle();
  await tester.tap(find.widgetWithText(ListTile, section).last);
  await tester.pumpAndSettle();
  await _settle(tester, seconds: 4);
}

Future<void> _back(WidgetTester tester) async {
  await tester.pageBack();
  await tester.pumpAndSettle();
  await _settle(tester, seconds: 2);
}

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('capture App Store shot list', (WidgetTester tester) async {
    // Redeem the reviewer code and seed the store before the app starts.
    await tester.runAsync(() async {
      final creds =
          await ProxyClient().demo(Config.defaultProxyUrl, _reviewCode);
      await PairingStore().save(creds);
      debugPrint('STEP paired via review code');
    });

    app.main();
    await tester.pumpAndSettle();
    await _settle(tester, seconds: 5);

    expect(find.text('Tracking'), findsWidgets,
        reason: 'seeded pairing should open straight on the Tracking screen');

    // --- 1) TRACKING: the colour-coded status list. ---
    await _step('01-tracking', () async {
      await _settle(tester, seconds: 3);
      await _shot(tester, '01-tracking');
    });

    // --- 2) SHIPMENT DETAIL: prefer an in-transit shipment for the map. ---
    await _step('02-detail-map', () async {
      Finder tile = find.widgetWithText(ListTile, 'In transit');
      if (tile.evaluate().isEmpty) {
        tile = find.widgetWithText(ListTile, 'Out for delivery');
      }
      if (tile.evaluate().isEmpty) {
        tile = find.byType(ListTile);
      }
      await tester.tap(tile.first);
      await tester.pumpAndSettle();
      // Map tiles and geocoded pins need real network time.
      await _settle(tester, seconds: 10);
      await _shot(tester, '02-detail-map');
      await _back(tester);
    });

    // --- 3) INSURANCE: the purchase form. ---
    await _step('03-insurance', () async {
      await _drawerTo(tester, 'Insurance');
      await tester
          .tap(find.widgetWithText(FloatingActionButton, 'Buy insurance'));
      await tester.pumpAndSettle();
      await _settle(tester, seconds: 2);
      await _shot(tester, '03-insurance');
      await _back(tester);
    });

    // --- 4) CLAIMS: the claim form. ---
    await _step('04-claims', () async {
      await _drawerTo(tester, 'Claims');
      await tester.tap(find.widgetWithText(FloatingActionButton, 'File a claim'));
      await tester.pumpAndSettle();
      await _settle(tester, seconds: 2);
      await _shot(tester, '04-claims');
      await _back(tester);
    });

    // --- 5) REPORTS: per-carrier spend breakdown. ---
    await _step('05-reports', () async {
      await _drawerTo(tester, 'Reports');
      await _settle(tester, seconds: 5);
      await _shot(tester, '05-reports');
    });

    // --- 6) HTS LOOKUP: duty rates for a sample search. ---
    await _step('06-hts', () async {
      await _drawerTo(tester, 'HTS Lookup');
      await tester.enterText(find.byType(TextField).first, 'copper');
      await tester.pumpAndSettle();
      await tester.tap(find.widgetWithText(FilledButton, 'Search'));
      await tester.pumpAndSettle();
      await _settle(tester, seconds: 8);
      await _shot(tester, '06-hts');
    });

    debugPrint('STEP all done');
  }, timeout: const Timeout(Duration(minutes: 15)));
}
