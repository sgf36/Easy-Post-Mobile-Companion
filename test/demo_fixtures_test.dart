// Fixtures exist so App Store screenshots are never a photograph of a real
// account. Two things have to hold, and only one of them is about the pictures.
//
// The pictures: the shot list must show the range of states the Tracking screen
// exists to display. A capture run once produced twelve consecutive "Delivered"
// rows because it photographed whatever the live account happened to hold.
//
// The safety: a shipping build must not be able to serve invented shipments to
// a real user. DEMO_FIXTURES is a compile-time constant, so in any build that
// does not define it the flag is false and the fixture client is unreachable.
import 'package:easypost_mobile_companion/services/demo_fixtures.dart';
import 'package:easypost_mobile_companion/services/proxy_client.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('fixtures are off unless explicitly compiled in', () {
    test('a normal build does not use fixtures', () {
      // This suite runs without --dart-define=DEMO_FIXTURES, i.e. exactly as a
      // release build is compiled. If this ever fails, a shipping app could
      // show a user shipments that do not exist.
      expect(ProxyClient.useFixtures, isFalse);
    });
  });

  group('the shot list shows what the app can do', () {
    test('tracker statuses span the range, not one repeated state', () {
      final statuses = demoTrackers.map((t) => t['status'] as String).toSet();

      expect(statuses.length, greaterThanOrEqualTo(5),
          reason: 'a screenshot of one repeated status sells nothing');
      // The unhappy paths are the point of a tracking app: a shipper wants to
      // see that failures and returns are surfaced, not just the happy case.
      expect(statuses, containsAll(<String>['failure', 'return_to_sender']));
      expect(statuses, containsAll(<String>['pre_transit', 'in_transit', 'delivered']));
    });

    test('more than one carrier is represented', () {
      final carriers = demoTrackers.map((t) => t['carrier'] as String).toSet();
      expect(carriers.length, greaterThanOrEqualTo(3),
          reason: 'the app is carrier-agnostic and the listing should show it');
    });

    test('every tracker carries scan history for the detail screen', () {
      for (final t in demoTrackers) {
        final details = t['tracking_details'] as List<dynamic>;
        expect(details, isNotEmpty,
            reason: '${t['tracking_code']} would render an empty detail view');
      }
    });
  });

  group('nothing in the fixtures is real', () {
    test('tracking codes use EasyPost test prefixes', () {
      for (final t in demoTrackers) {
        expect(t['tracking_code'] as String, startsWith('EZ'),
            reason: 'a real tracking number must never reach a public listing');
      }
    });

    test('the real Royal Mail label from release testing is absent', () {
      // This exact code was photographed onto a capture run before fixtures
      // existed. Naming it keeps that specific regression from returning.
      final codes = <String>[
        ...demoTrackers.map((t) => t['tracking_code'] as String),
        ...demoShipments.map((s) => s['tracking_code'] as String),
        ...demoInsurances.map((i) => i['tracking_code'] as String),
        ...demoClaims.map((c) => c['tracking_code'] as String),
      ];
      expect(codes, isNot(contains('TT020396360GB')));
    });

    test('identifiers are obviously invented', () {
      for (final t in demoTrackers) {
        expect(t['id'] as String, startsWith('trk_demo_'));
      }
      for (final s in demoShipments) {
        expect(s['id'] as String, startsWith('shp_demo_'));
      }
    });

    test('dates are fixed, so two capture runs are comparable', () {
      // A relative date would redraw every ETA daily and make it impossible to
      // tell a real change from the calendar moving.
      for (final t in demoTrackers) {
        expect(t['est_delivery_date'] as String, startsWith('2026-'));
      }
    });
  });
}
