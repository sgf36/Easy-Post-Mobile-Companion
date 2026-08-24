// A Royal Mail parcel delivered at "Watford DO" was drawn on the map off the
// coast of Brazil. Nominatim's first free-text hit for "Watford DO" is a street
// called Watford in Natal, Rio Grande do Norte, and nothing checked that the
// answer was in the right country — or on the right continent.
//
// These tests cover the parts that decide, so the fix cannot quietly rot: the
// suffix stripping, the country gate, and the plausibility check. The network
// call itself is not exercised here.
import 'package:easypost_mobile_companion/models/tracker.dart';
import 'package:easypost_mobile_companion/services/geocode.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('depot suffixes are not part of a place name', () {
    test('the exact string that caused the Brazil pin', () {
      expect(Geocoder.cleanPlace('Watford DO'), 'Watford');
    });

    test('the other suffixes carriers use', () {
      expect(Geocoder.cleanPlace('Medway MC'), 'Medway');
      expect(Geocoder.cleanPlace('Warrington RDC'), 'Warrington');
      expect(Geocoder.cleanPlace('Watford Delivery Office'), 'Watford');
      expect(Geocoder.cleanPlace('Sheffield Mail Centre'), 'Sheffield');
      expect(Geocoder.cleanPlace('Home Counties North DC'), 'Home Counties North');
    });

    test('stacked suffixes come off together', () {
      expect(Geocoder.cleanPlace('Watford Mail Centre DO'), 'Watford');
    });

    test('a place is never stripped to nothing', () {
      // "DO" alone is not a city, but returning "" would send an empty query.
      expect(Geocoder.cleanPlace('DO'), 'DO');
    });

    test('only a whole trailing word is stripped', () {
      // Cities that merely end in those letters must survive intact.
      expect(Geocoder.cleanPlace('Waterloo'), 'Waterloo');
      expect(Geocoder.cleanPlace('Sidcup'), 'Sidcup');
      expect(Geocoder.cleanPlace('Dorchester'), 'Dorchester');
    });

    test('ordinary place names are untouched', () {
      expect(Geocoder.cleanPlace('Watford'), 'Watford');
      expect(Geocoder.cleanPlace('Milton Keynes'), 'Milton Keynes');
    });
  });

  group('the country gate', () {
    test('a two-letter code is accepted, in either case', () {
      expect(Geocoder.countryCode('GB'), 'gb');
      expect(Geocoder.countryCode('us'), 'us');
    });

    test('anything else is absent rather than guessed', () {
      // "United Kingdom" and "GBR" are not what countrycodes wants, and
      // passing them through unconstrains the query — which is the bug.
      expect(Geocoder.countryCode('United Kingdom'), isNull);
      expect(Geocoder.countryCode('GBR'), isNull);
      expect(Geocoder.countryCode(''), isNull);
      expect(Geocoder.countryCode(null), isNull);
    });

    test('no country means no lookup at all', () async {
      // The whole failure mode: an uncountried city name always matches
      // something, somewhere. Refusing is the point.
      expect(await Geocoder.lookup(city: 'Watford DO'), isNull);
      expect(await Geocoder.lookup(city: 'Watford', country: 'United Kingdom'), isNull);
    });

    test('no place means no lookup either', () async {
      expect(await Geocoder.lookup(country: 'GB'), isNull);
      expect(await Geocoder.lookup(city: '   ', country: 'GB'), isNull);
    });
  });

  group('the journey supplies a country when a scan does not', () {
    test('carrier_detail destination is used', () {
      final t = Tracker.fromJson({
        'id': 'trk_1',
        'tracking_code': 'OK828900054GB',
        'carrier': 'RoyalMailV3',
        'status': 'delivered',
        'carrier_detail': {
          'destination_tracking_location': {'city': 'Watford', 'country': 'GB'},
        },
        'tracking_details': [
          {
            'status': 'delivered',
            'datetime': '2026-08-24T11:48:00Z',
            'tracking_location': {'city': 'Watford DO'},
          },
        ],
      });
      expect(t.fallbackCountry, 'GB');
      expect(t.events.single.city, 'Watford DO');
      expect(t.events.single.country, isNull);
    });

    test('origin is used when there is no destination', () {
      final t = Tracker.fromJson({
        'id': 'trk_2',
        'tracking_code': 'X',
        'carrier': 'RoyalMailV3',
        'status': 'in_transit',
        'carrier_detail': {
          'origin_tracking_location': {'city': 'Sheffield', 'country': 'GB'},
        },
        'tracking_details': const [],
      });
      expect(t.fallbackCountry, 'GB');
    });

    test('an event that does carry a country is the last resort', () {
      final t = Tracker.fromJson({
        'id': 'trk_3',
        'tracking_code': 'X',
        'carrier': 'USPS',
        'status': 'in_transit',
        'tracking_details': [
          {'status': 'in_transit', 'tracking_location': {'city': 'Watford DO'}},
          {'status': 'in_transit', 'tracking_location': {'city': 'Leeds', 'country': 'GB'}},
        ],
      });
      expect(t.fallbackCountry, 'GB');
    });

    test('nothing anywhere leaves it null, and the map stays empty', () {
      final t = Tracker.fromJson({
        'id': 'trk_4',
        'tracking_code': 'X',
        'carrier': 'RoyalMailV3',
        'status': 'in_transit',
        'tracking_details': [
          {'status': 'in_transit', 'tracking_location': {'city': 'Watford DO'}},
        ],
      });
      expect(t.fallbackCountry, isNull);
    });
  });
}
