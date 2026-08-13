import 'package:flutter_test/flutter_test.dart';

import 'package:easypost_mobile_companion/models/tracker.dart';

/// Carrier names and the status detail line, both of which reached a public
/// App Store capture reading like internal plumbing.
void main() {
  _spendTests();
  group('carrierDisplayName', () {
    test('humanises the codes the fixtures actually use', () {
      // Every carrier in demo_fixtures.dart, since these are the ones that end
      // up in the screenshots.
      expect(carrierDisplayName('RoyalMailV3'), 'Royal Mail V3');
      expect(carrierDisplayName('DHLExpress'), 'DHL Express');
      expect(carrierDisplayName('USPS'), 'USPS');
      expect(carrierDisplayName('FedEx'), 'FedEx');
      expect(carrierDisplayName('Evri'), 'Evri');
    });

    test('leaves a name that is already its own code alone', () {
      // The desktop regression this mirrors: a caller inferred "not recognised"
      // by comparing the humanised result with the input, so carriers whose
      // display name *is* their code were camel-split. "Fed Ex" shipped.
      expect(carrierDisplayName('FedEx'), isNot('Fed Ex'));
      expect(carrierDisplayName('USPS'), isNot('U S P S'));
    });

    test('is case-insensitive on the lookup', () {
      expect(carrierDisplayName('royalmailv3'), 'Royal Mail V3');
      expect(carrierDisplayName('ROYALMAILV3'), 'Royal Mail V3');
    });

    test('splits an unknown code rather than printing it raw', () {
      expect(carrierDisplayName('SomeNewCarrier'), 'Some New Carrier');
    });

    test('keeps a version suffix attached', () {
      // "V3" is a version, not a word. An unknown code ending in one should not
      // become "V 3".
      expect(carrierDisplayName('MadeUpMailV2'), 'Made Up Mail V2');
    });

    test('is total — never returns null or throws', () {
      expect(carrierDisplayName(''), '');
      expect(carrierDisplayName('x'), 'x');
    });
  });

  group('statusDetailText', () {
    test('drops "unknown", which is what EasyPost sends most of the time', () {
      // Printed verbatim it reads as the app not knowing what is happening,
      // rather than the carrier not having elaborated.
      expect(statusDetailText('in_transit', 'unknown'), isNull);
      expect(statusDetailText('in_transit', 'UNKNOWN'), isNull);
    });

    test('drops a detail that merely restates the status', () {
      expect(statusDetailText('in_transit', 'in_transit'), isNull);
      expect(statusDetailText('delivered', 'Delivered'), isNull);
    });

    test('drops nothing useful', () {
      expect(statusDetailText('in_transit', 'arrived_at_facility'),
          'arrived at facility');
      expect(statusDetailText('failure', 'address_incorrect'), 'address incorrect');
    });

    test('handles absent and empty details', () {
      expect(statusDetailText('in_transit', null), isNull);
      expect(statusDetailText('in_transit', ''), isNull);
      expect(statusDetailText('in_transit', '   '), isNull);
    });
  });
}

/// Spend across more than one currency.
///
/// The Reports screen used to add every amount together and label the result
/// with whichever currency the *first* shipment happened to carry. The App
/// Store capture showed "26.45 USD" for 8.40 USD plus 6.85 and 11.20 GBP — a
/// wrong number, stated confidently, on a public listing.
void _spendTests() {
  group('formatSpend', () {
    test('keeps currencies apart instead of summing them', () {
      // Exactly the fixture data that produced the bad screenshot.
      final label = formatSpend({'USD': 8.40, 'GBP': 18.05});
      expect(label, contains('8.40 USD'));
      expect(label, contains('18.05 GBP'));
      expect(label, isNot(contains('26.45')));
    });

    test('orders largest first', () {
      expect(formatSpend({'USD': 8.40, 'GBP': 18.05}), startsWith('18.05 GBP'));
    });

    test('a single currency reads as one plain figure', () {
      expect(formatSpend({'GBP': 18.05}), '18.05 GBP');
    });

    test('handles an unnamed currency and an empty report', () {
      expect(formatSpend({'': 5}), '5.00');
      expect(formatSpend({}), '0.00');
    });
  });
}
