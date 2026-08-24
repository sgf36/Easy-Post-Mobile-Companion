import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';

/// Best-effort geocoding of a carrier scan location via OpenStreetMap's
/// Nominatim service. EasyPost gives only city-level locations, so map pins are
/// approximate. Failures return null and the map omits that pin.
///
/// **A wrong pin is worse than no pin**, and this used to produce them. A Royal
/// Mail parcel delivered at "Watford DO" was plotted off the coast of Brazil:
/// the query went to Nominatim as free text with no country constraint, and the
/// first hit for "Watford DO" is a street called Watford in Natal, Rio Grande
/// do Norte. The map showed it without hesitation, because nothing checked that
/// the answer was anywhere near the right country.
///
/// Three things guard against that now, and the order matters.
class Geocoder {
  static const _endpoint = 'https://nominatim.openstreetmap.org/search';
  static final Map<String, LatLng?> _cache = {};

  /// Suffixes carriers append to a depot name that are not part of any place.
  ///
  /// Royal Mail is the reason this exists — "Watford DO" is Watford Delivery
  /// Office — but every carrier does some version of it. Matched only as a
  /// whole trailing word, so a city legitimately ending in these letters is
  /// left alone.
  static final _depotSuffix = RegExp(
    r'\s+(DO|MC|RDC|NDC|SC|DC|PFC|HUB|DEPOT|DELIVERY\s+OFFICE|MAIL\s+CENTRE|'
    r'SORTING\s+CENTRE|DISTRIBUTION\s+CENTRE)$',
    caseSensitive: false,
  );

  /// Strips depot suffixes, repeatedly — "Watford DO" and "Watford Mail Centre
  /// DO" both reduce to "Watford".
  static String cleanPlace(String raw) {
    var s = raw.trim();
    for (var i = 0; i < 3; i++) {
      final next = s.replaceFirst(_depotSuffix, '').trim();
      if (next == s || next.isEmpty) break;
      s = next;
    }
    return s;
  }

  /// Two letters, which is what Nominatim's `countrycodes` wants. EasyPost
  /// sends ISO-2 already; anything else is treated as absent rather than
  /// guessed at.
  static String? countryCode(String? raw) {
    final c = (raw ?? '').trim();
    return RegExp(r'^[A-Za-z]{2}$').hasMatch(c) ? c.toLowerCase() : null;
  }

  static Future<LatLng?> lookup({String? city, String? state, String? country}) async {
    final cc = countryCode(country);

    // No country, no lookup. This is the change that actually prevents the
    // Brazil pin: unconstrained free text always finds *something* somewhere in
    // the world, and there is no way to tell from the result that it is wrong.
    // A missing pin is a gap in a journey line; a wrong one is a false claim
    // about where a parcel went.
    if (cc == null) return null;

    final place = [city, state]
        .where((p) => p != null && p.trim().isNotEmpty)
        .map((p) => cleanPlace(p!))
        .where((p) => p.isNotEmpty)
        .join(', ');
    if (place.isEmpty) return null;

    final key = '$place|$cc';
    if (_cache.containsKey(key)) return _cache[key];

    try {
      final uri = Uri.parse(
        '$_endpoint?format=json&limit=1&addressdetails=1'
        '&countrycodes=$cc'
        '&q=${Uri.encodeQueryComponent(place)}',
      );
      final res = await http.get(
        uri,
        headers: {'User-Agent': 'EasyPostMobileCompanion/1.1 (support@spencerfields.com)'},
      ).timeout(const Duration(seconds: 8));
      if (res.statusCode == 200) {
        final list = jsonDecode(res.body) as List<dynamic>;
        if (list.isNotEmpty) {
          final m = list.first as Map<String, dynamic>;
          // Check the answer came back in the country that was asked for.
          // countrycodes should guarantee it, but the whole class of bug here
          // was trusting the service to have understood the question.
          final got = (m['address'] as Map<String, dynamic>?)?['country_code']
              ?.toString()
              .toLowerCase();
          if (got != null && got != cc) {
            _cache[key] = null;
            return null;
          }
          final lat = double.tryParse(m['lat'].toString());
          final lon = double.tryParse(m['lon'].toString());
          if (lat == null || lon == null || !_plausible(lat, lon)) {
            _cache[key] = null;
            return null;
          }
          final ll = LatLng(lat, lon);
          _cache[key] = ll;
          return ll;
        }
      }
    } catch (_) {
      // fall through to caching null
    }
    _cache[key] = null;
    return null;
  }

  /// Rejects out-of-range values and the null-island corner. Exactly 0,0 is in
  /// the Gulf of Guinea and is what a service returns when it has parsed
  /// nothing — it is never a real scan location.
  static bool _plausible(double lat, double lon) {
    if (lat.abs() > 90 || lon.abs() > 180) return false;
    if (lat == 0 && lon == 0) return false;
    return true;
  }
}
