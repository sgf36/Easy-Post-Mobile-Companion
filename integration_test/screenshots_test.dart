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
// **Nothing here may be found by its English text.** The app is localised and
// this same test drives the German, Japanese and Chinese captures, so every
// finder is a widget type, an icon, or a tracking code -- none of which
// translate. That extends to Flutter's own widgets: `find.byTooltip('Open
// navigation menu')` and `tester.pageBack()` both match a MaterialLocalizations
// string, so they find nothing outside English and are avoided here.
//
// Capture tooling only -- not part of the shipped app or its test suite.
//
// Usage, against a booted 6.9-inch simulator (iPhone 16 or 17 Pro Max):
//
//   python3 tool/shotserver.py &
//   flutter test integration_test/screenshots_test.dart -d "iPhone 16 Pro Max" \
//       --dart-define=DEMO_FIXTURES=true --dart-define=UI_LOCALE=de
//
// The PNGs land in ~/Desktop/asc-screenshots at 1320x2868.
import 'package:easypost_mobile_companion/config.dart';
import 'package:easypost_mobile_companion/main.dart' as app;
import 'package:easypost_mobile_companion/screens/trackers_screen.dart';
import 'package:easypost_mobile_companion/services/pairing_store.dart';
import 'package:easypost_mobile_companion/services/proxy_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:integration_test/integration_test.dart';

const String _reviewCode = 'epmc-demo-7f3a9c2e';
const String _shotServer = 'http://127.0.0.1:8099';

/// The in-transit fixture. A tracking code is the one label on the Tracking
/// screen that is identical in every language, so the detail shot is opened by
/// this rather than by tapping the row whose badge reads "In transit".
const String _inTransitCode = 'EZ2000000002';

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

/// Opens the nav drawer and taps the section carrying [icon].
///
/// The drawer entries are identified by their icons, which are the same widget
/// in every language; their labels are not.
Future<void> _drawerTo(WidgetTester tester, IconData icon) async {
  final ScaffoldState scaffold = tester.firstState(find.byType(Scaffold));
  scaffold.openDrawer();
  await tester.pumpAndSettle();
  await tester.tap(find.widgetWithIcon(ListTile, icon).last);
  await tester.pumpAndSettle();
  await _settle(tester, seconds: 4);
}

/// Pops the current route. `tester.pageBack()` looks for a tooltip reading
/// "Back", which is a MaterialLocalizations string and therefore absent in
/// every language but English.
Future<void> _back(WidgetTester tester) async {
  final NavigatorState navigator = tester.state(find.byType(Navigator).first);
  navigator.pop();
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

    expect(find.byType(TrackersScreen), findsOneWidget,
        reason: 'seeded pairing should open straight on the Tracking screen');

    // --- 1) TRACKING: the colour-coded status list. ---
    await _step('01-tracking', () async {
      await _settle(tester, seconds: 3);
      await _shot(tester, '01-tracking');
    });

    // --- 2) SHIPMENT DETAIL: the in-transit shipment, which has the journey. ---
    await _step('02-detail-map', () async {
      Finder tile = find.widgetWithText(ListTile, _inTransitCode);
      if (tile.evaluate().isEmpty) tile = find.byType(ListTile);
      await tester.scrollUntilVisible(tile.first, 200,
          scrollable: find.byType(Scrollable).first);
      await tester.pumpAndSettle();
      await tester.tap(tile.first);
      await tester.pumpAndSettle();
      // Map tiles and geocoded pins need real network time.
      await _settle(tester, seconds: 10);
      await _shot(tester, '02-detail-map');
      await _back(tester);
    });

    // --- 3) INSURANCE: the policies already on the account, read only. ---
    //
    // This used to tap a floating action button and photograph the "Buy
    // insurance" form. That form no longer exists: buying insurance and filing
    // claims were removed from the app because App Review treats insurance as a
    // highly regulated service under guideline 5.1.1(ix), which an individual
    // developer account may not offer. Tapping a FloatingActionButton here now
    // fails outright, and the shipped 1.0 screenshots still advertise both
    // forms — a store listing showing functionality the binary does not have.
    //
    // So capture the list itself, like reports and HTS below: no tap, no route
    // to pop.
    await _step('03-insurance', () async {
      await _drawerTo(tester, Icons.verified_user);
      await _settle(tester, seconds: 3);
      await _shot(tester, '03-insurance');
    });

    // --- 4) CLAIMS: claims raised on the account and their status. ---
    await _step('04-claims', () async {
      await _drawerTo(tester, Icons.gavel);
      await _settle(tester, seconds: 3);
      await _shot(tester, '04-claims');
    });

    // --- 5) REPORTS: per-carrier spend breakdown. ---
    await _step('05-reports', () async {
      await _drawerTo(tester, Icons.bar_chart);
      await _settle(tester, seconds: 5);
      await _shot(tester, '05-reports');
    });

    // --- 6) HTS LOOKUP: duty rates for a sample search. ---
    await _step('06-hts', () async {
      await _drawerTo(tester, Icons.travel_explore);
      // "copper" is a keyword sent to a US tariff database, not UI text: the
      // service indexes English descriptions, so it stays English in every
      // locale or the search returns nothing to photograph.
      await tester.enterText(find.byType(TextField).first, 'copper');
      await tester.pumpAndSettle();
      await tester.tap(find.byType(FilledButton).first);
      await tester.pumpAndSettle();
      await _settle(tester, seconds: 8);
      await _shot(tester, '06-hts');
    });

    debugPrint('STEP all done');
  }, timeout: const Timeout(Duration(minutes: 15)));
}
