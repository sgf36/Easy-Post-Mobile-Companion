// The Refunds section: which shipments belong in it, in what order, and how
// its three states read.
//
// The list is derived from the shipments collection because a refund asked for
// the way Easy-Post Desktop asks for one sets `refund_status` on the shipment
// and creates no Refund object. The first test here is the one that would have
// caught building this on `/refunds` instead: a screen fed from that endpoint
// answers with an empty list, which looks exactly like "no refunds" and never
// once looks like a bug.
import 'package:easypost_mobile_companion/l10n/app_localizations.dart';
import 'package:easypost_mobile_companion/models/tracker.dart';
import 'package:easypost_mobile_companion/services/demo_fixtures.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

Map<String, dynamic> shipment(String id, {String? refund, String? created}) => {
      'id': id,
      'tracking_code': 'EZ$id',
      'status': 'pre_transit',
      'created_at': ?created,
      'refund_status': ?refund,
    };

void main() {
  group('which shipments are refund requests', () {
    test('only those carrying a refund status', () {
      final rows = refundRequests([
        shipment('1'),
        shipment('2', refund: 'submitted'),
        shipment('3'),
        shipment('4', refund: 'refunded'),
      ]);
      expect(rows.map((r) => r['id']), ['2', '4']);
    });

    test('a blank or whitespace refund status is not a request', () {
      // EasyPost sends the field on every shipment; only some of them carry a
      // value. Testing truthiness rather than emptiness would have put every
      // label in the account on this screen.
      final rows = refundRequests([
        shipment('1', refund: ''),
        shipment('2', refund: '   '),
        shipment('3', refund: 'submitted'),
      ]);
      expect(rows.map((r) => r['id']), ['3']);
    });

    test('nothing at all is an empty list, not a failure', () {
      expect(refundRequests(const []), isEmpty);
      expect(refundRequests([shipment('1')]), isEmpty);
    });
  });

  group('order', () {
    test('what is still waiting comes before what is settled', () {
      final rows = refundRequests([
        shipment('settled', refund: 'refunded'),
        shipment('refused', refund: 'rejected'),
        shipment('waiting', refund: 'submitted'),
      ]);
      expect(rows.map((r) => r['id']), ['waiting', 'refused', 'settled']);
    });

    test('within one state, newest first', () {
      final rows = refundRequests([
        shipment('old', refund: 'submitted', created: '2026-08-01T00:00:00Z'),
        shipment('new', refund: 'submitted', created: '2026-08-14T00:00:00Z'),
        shipment('mid', refund: 'submitted', created: '2026-08-07T00:00:00Z'),
      ]);
      expect(rows.map((r) => r['id']), ['new', 'mid', 'old']);
    });

    test('an unreadable date sorts last rather than losing the row', () {
      final rows = refundRequests([
        shipment('undated', refund: 'submitted'),
        shipment('dated', refund: 'submitted', created: '2026-08-01T00:00:00Z'),
      ]);
      expect(rows.map((r) => r['id']), ['dated', 'undated']);
    });

    test('a state EasyPost has not published yet sorts after the known ones',
        () {
      final rows = refundRequests([
        shipment('new-state', refund: 'under_review'),
        shipment('settled', refund: 'refunded'),
      ]);
      expect(rows.map((r) => r['id']), ['settled', 'new-state']);
    });
  });

  group('how the states read', () {
    late AppLocalizations en;
    late AppLocalizations de;
    late AppLocalizations ja;

    setUpAll(() async {
      en = await AppLocalizations.delegate.load(const Locale('en'));
      de = await AppLocalizations.delegate.load(const Locale('de'));
      ja = await AppLocalizations.delegate.load(const Locale('ja'));
    });

    test('a refund state is prose and changes with the language', () {
      expect(refundStatusLabel(en, 'submitted'), 'Submitted');
      expect(refundStatusLabel(de, 'submitted'), isNot('Submitted'));
      expect(refundStatusLabel(ja, 'refunded'), isNot('Refunded'));
    });

    test('never the raw code, in any language', () {
      for (final t in [en, de, ja]) {
        for (final state in ['submitted', 'refunded', 'rejected']) {
          expect(refundStatusLabel(t, state), isNot(contains('_')));
          expect(refundStatusLabel(t, state), isNotEmpty);
        }
      }
    });

    test('a state nobody has seen before reads as words', () {
      expect(refundStatusLabel(de, 'under_review'), de.statusUnknown);
    });

    test('an absent state stays absent rather than becoming "Unknown"', () {
      // Same rule as statusText: stamping a word on an unlabelled record
      // asserts something the API did not say.
      expect(refundStatusText(en, null), '');
      expect(refundStatusText(en, '   '), '');
      expect(refundStatusText(en, 'submitted'), en.refundStatusSubmitted);
    });

    test('a refund state is not read against the shipment vocabulary', () {
      // The two tables overlap in shape and not in meaning. Passing a refund
      // state to statusLabel is how this screen would have come to say
      // "Unknown" on every row.
      expect(statusLabel(en, 'submitted'), en.statusUnknown);
      expect(refundStatusLabel(en, 'delivered'), en.statusUnknown);
    });

    test('each state gets its own icon and colour', () {
      final styles = ['submitted', 'refunded', 'rejected']
          .map(refundStatusStyle)
          .toList();
      expect(styles.map((s) => s.icon).toSet(), hasLength(3));
      expect(styles.map((s) => s.color).toSet(), hasLength(3));
    });
  });

  group('the shot list can show this screen', () {
    test('the fixtures cover all three states', () {
      // A capture run photographs whatever the fixtures hold, and a Refunds
      // screenshot of one repeated state sells nothing — the same reason the
      // tracker fixtures span the range.
      final states =
          refundRequests(demoShipments).map(refundStateOf).toSet();
      expect(states, {'submitted', 'refunded', 'rejected'});
    });

    test('every refund row carries a rate, so the screen can price it', () {
      for (final row in refundRequests(demoShipments)) {
        expect(row['selected_rate'], isA<Map<String, dynamic>>(),
            reason: '${row['id']} would render a blank cost');
      }
    });
  });
}
