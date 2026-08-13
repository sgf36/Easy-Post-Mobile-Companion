import 'dart:convert';

import 'package:http/http.dart' as http;

/// One Harmonized Tariff Schedule row from the USITC search.
class HtsResult {
  final String htsno;
  final String description;
  final String general;
  final String special;
  final String other;
  final String units;

  HtsResult({
    required this.htsno,
    required this.description,
    this.general = '',
    this.special = '',
    this.other = '',
    this.units = '',
  });

  factory HtsResult.fromJson(Map<String, dynamic> j) {
    String s(dynamic v) {
      if (v == null) return '';
      if (v is List) return v.map((e) => '$e').join(', ');
      return '$v';
    }

    return HtsResult(
      htsno: s(j['htsno']),
      description: s(j['description']),
      general: s(j['general']),
      special: s(j['special']),
      other: s(j['other']),
      units: s(j['units']),
    );
  }
}

/// The tariff service refused or failed. Carries the status code so the UI can
/// say so in the reader's language; see services/error_text.dart.
class HtsUnavailableException implements Exception {
  final int statusCode;
  HtsUnavailableException(this.statusCode);
  @override
  String toString() =>
      'The tariff service is unavailable (error $statusCode). Please try again.';
}

/// Live HTS code lookup against the U.S. International Trade Commission's public
/// search endpoint (no key required). Mirrors the desktop HTS Lookup.
Future<List<HtsResult>> searchHts(String keyword) async {
  final uri = Uri.parse('https://hts.usitc.gov/reststop/search?keyword=${Uri.encodeQueryComponent(keyword)}');
  final res = await http
      .get(uri, headers: {'accept': 'application/json'})
      .timeout(const Duration(seconds: 12));
  if (res.statusCode != 200) {
    throw HtsUnavailableException(res.statusCode);
  }
  final decoded = jsonDecode(res.body);
  final list = decoded is List
      ? decoded
      : (decoded is Map ? (decoded['results'] as List<dynamic>? ?? const []) : const []);
  return list
      .whereType<Map<String, dynamic>>()
      .map(HtsResult.fromJson)
      .where((r) => r.htsno.isNotEmpty || r.description.isNotEmpty)
      .toList();
}
