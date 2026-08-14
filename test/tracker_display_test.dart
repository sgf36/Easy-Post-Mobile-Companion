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
  group('formatAddress', () {
    test('joins only the lines the address actually carries', () {
      expect(
        formatAddress({
          'name': 'Acme Ltd',
          'street1': '10 Downing Street',
          'street2': '',
          'city': 'London',
          'state': null,
          'zip': 'SW1A 2AA',
          'country': 'GB',
        }),
        'Acme Ltd, 10 Downing Street, London, SW1A 2AA, GB',
      );
    });

    test('does not print a company that merely repeats the name', () {
      expect(
        formatAddress({'name': 'Acme Ltd', 'company': 'ACME LTD', 'city': 'London'}),
        'Acme Ltd, London',
      );
    });

    test('an absent or malformed address is empty, not a row of commas', () {
      expect(formatAddress(null), '');
      expect(formatAddress('221B Baker Street'), '');
      expect(formatAddress(const {}), '');
      expect(formatAddress(const {'city': '', 'country': ''}), '');
    });
  });

  group('formatMoney', () {
    test('renders the exact string the Insurance list got wrong', () {
      // EasyPost sends an insurance amount as "5000.00000". The list printed
      // '$' + that, verbatim: "$5000.00000".
      expect(formatMoney('5000.00000'), '5,000.00 USD');
    });

    test('groups thousands and stops at two decimals', () {
      expect(formatMoney('1234567.89123'), '1,234,567.89 USD');
      expect(formatMoney(42), '42.00 USD');
    });

    test('never asserts a currency symbol', () {
      expect(formatMoney('10.00', currency: 'EUR'), isNot(contains(r'$')));
      expect(formatMoney('10.00', currency: 'EUR'), '10.00 EUR');
    });

    test('follows the locale rather than a hardcoded separator', () {
      // German swaps both separators; "1.234,56" is a different number in
      // English, so this is a correctness case and not a cosmetic one.
      expect(formatMoney('1234.56', locale: 'de'), '1.234,56 USD');
    });

    test('a missing amount stays missing rather than becoming zero', () {
      expect(formatMoney(null), '');
      expect(formatMoney(''), '');
      expect(formatMoney('not a number'), '');
      // A real zero is still a figure worth printing.
      expect(formatMoney('0'), '0.00 USD');
    });

    test('an unnamed currency prints the figure alone', () {
      expect(formatMoney('12.5', currency: ''), '12.50');
    });
  });

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
