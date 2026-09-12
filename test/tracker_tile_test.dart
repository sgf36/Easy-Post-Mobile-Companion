import 'package:easypost_mobile_companion/l10n/app_localizations.dart';
import 'package:easypost_mobile_companion/models/tracker.dart';
import 'package:easypost_mobile_companion/screens/trackers_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// A row is bounded by the tile it sits in, and nothing else here notices when
/// its contents stop fitting.
///
/// Adding the purchase date and the refund state overflowed the tile by 12
/// pixels. Analysis was clean and every unit test passed; it surfaced in a
/// screenshot run twenty minutes later, as a rendering exception after the
/// pictures had been taken. On a phone it draws a striped bar across the row.
void main() {
  Future<void> pumpRow(
    WidgetTester tester, {
    required Locale locale,
    Map<String, dynamic>? shipment,
    required Tracker tracker,
  }) async {
    tester.view.physicalSize = const Size(1170, 2532); // iPhone 13 Pro
    tester.view.devicePixelRatio = 3.0;
    addTearDown(tester.view.reset);
    await tester.pumpWidget(MaterialApp(
      locale: locale,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: Scaffold(
        body: ListView(children: [TrackerTile(tracker: tracker, shipment: shipment)]),
      ),
    ));
    await tester.pumpAndSettle();
  }

  final worstCase = Tracker.fromJson({
    'id': 'trk_1',
    'tracking_code': 'EZ1000000001',
    // The longest carrier name beside the longest status the app can print.
    'carrier': 'DHLExpress',
    'status': 'available_for_pickup',
    'est_delivery_date': '2026-08-16',
    'shipment_id': 'shp_1',
  });

  final worstShipment = <String, dynamic>{
    'id': 'shp_1',
    'created_at': '2026-08-12T10:15:00Z',
    'refund_status': 'submitted',
    'to_address': {'city': 'Newcastle upon Tyne', 'state': '', 'country': 'GB'},
  };

  for (final locale in [const Locale('en'), const Locale('de'), const Locale('fr')]) {
    testWidgets('a full row fits the tile in ${locale.languageCode}', (tester) async {
      await pumpRow(tester, locale: locale, tracker: worstCase, shipment: worstShipment);
      expect(tester.takeException(), isNull);
    });
  }

  testWidgets('a tracker with no shipment fits too', (tester) async {
    await pumpRow(tester, locale: const Locale('de'), tracker: worstCase, shipment: null);
    expect(tester.takeException(), isNull);
  });

  testWidgets('a row with nothing on the third line is not padded out to it', (tester) async {
    // The three-line height has to be asked for per row. Asked for always, a
    // parcel added by tracking number sits above a gap the size of the line it
    // has nothing to put on, which the screenshots showed as a hole in the list.
    await pumpRow(tester, locale: const Locale('en'), tracker: worstCase, shipment: null);
    final bare = tester.getSize(find.byType(TrackerTile)).height;
    await pumpRow(tester, locale: const Locale('en'), tracker: worstCase, shipment: worstShipment);
    final full = tester.getSize(find.byType(TrackerTile)).height;
    expect(bare, lessThan(full));
  });
}
