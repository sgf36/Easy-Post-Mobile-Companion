import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';

/// Best-effort geocoding of a city/state to coordinates via OpenStreetMap's
/// Nominatim service. EasyPost gives only city-level locations, so map pins are
/// approximate. Results are cached in-memory; failures return null (the map
/// simply omits that pin rather than erroring).
class Geocoder {
  static const _endpoint = 'https://nominatim.openstreetmap.org/search';
  static final Map<String, LatLng?> _cache = {};

  static Future<LatLng?> lookup({String? city, String? state, String? country}) async {
    final parts = [city, state, country]
        .where((p) => p != null && p.trim().isNotEmpty)
        .map((p) => p!.trim())
        .toList();
    if (parts.isEmpty) return null;
    final query = parts.join(', ');
    if (_cache.containsKey(query)) return _cache[query];

    try {
      final uri = Uri.parse('$_endpoint?format=json&limit=1&q=${Uri.encodeQueryComponent(query)}');
      final res = await http.get(
        uri,
        headers: {'User-Agent': 'EasyPostMobileCompanion/1.0 (support@spencerfields.com)'},
      ).timeout(const Duration(seconds: 8));
      if (res.statusCode == 200) {
        final list = jsonDecode(res.body) as List<dynamic>;
        if (list.isNotEmpty) {
          final m = list.first as Map<String, dynamic>;
          final ll = LatLng(double.parse(m['lat'].toString()), double.parse(m['lon'].toString()));
          _cache[query] = ll;
          return ll;
        }
      }
    } catch (_) {
      // fall through to caching null
    }
    _cache[query] = null;
    return null;
  }
}
