import 'dart:convert';
import 'dart:io' show Platform;

import 'package:http/http.dart' as http;

import 'pairing_store.dart';

/// A failure with a message safe to show the user.
class ProxyException implements Exception {
  final String message;
  ProxyException(this.message);
  @override
  String toString() => message;
}

/// Talks to the easypost-mobile-proxy Worker. The phone never holds the raw
/// EasyPost key; it presents its device token + KEK and the proxy decrypts,
/// calls EasyPost, and returns only allow-listed data.
class ProxyClient {
  String get _platform => Platform.isIOS ? 'ios' : 'android';

  /// Redeem a one-time pairing token (from the desktop QR) for a device token
  /// and KEK.
  Future<PairingCredentials> claim(String proxyUrl, String pairingToken) async {
    final res = await http.post(
      Uri.parse('$proxyUrl/pair/claim'),
      headers: const {'content-type': 'application/json'},
      body: jsonEncode({'pairing_token': pairingToken, 'platform': _platform}),
    );
    return _asCredentials(
      proxyUrl,
      res,
      onFail:
          'That pairing code is invalid or has expired. Generate a fresh one on the desktop.',
    );
  }

  /// Reviewer path: redeem a review code for a demo (test-mode) device.
  Future<PairingCredentials> demo(String proxyUrl, String code) async {
    final res = await http.post(
      Uri.parse('$proxyUrl/pair/demo'),
      headers: const {'content-type': 'application/json'},
      body: jsonEncode({'code': code, 'platform': _platform}),
    );
    return _asCredentials(proxyUrl, res, onFail: 'That review code was not accepted.');
  }

  PairingCredentials _asCredentials(
    String proxyUrl,
    http.Response res, {
    required String onFail,
  }) {
    if (res.statusCode != 200) throw ProxyException(onFail);
    final body = jsonDecode(res.body) as Map<String, dynamic>;
    final token = body['device_token'] as String?;
    final kek = body['kek'] as String?;
    if (token == null || kek == null) {
      throw ProxyException('Unexpected response from the pairing service.');
    }
    return PairingCredentials(deviceToken: token, kek: kek, proxyUrl: proxyUrl);
  }

  Map<String, String> _authHeaders(PairingCredentials c) => {
        'authorization': 'Bearer ${c.deviceToken}',
        'x-ep-kek': c.kek,
      };

  /// GET an allow-listed EasyPost collection through the proxy and return the
  /// array under [key] (e.g. "trackers", "shipments").
  Future<List<Map<String, dynamic>>> _getList(
    PairingCredentials c,
    String path,
    String key,
  ) async {
    final res = await http.get(Uri.parse('${c.proxyUrl}$path'), headers: _authHeaders(c));
    if (res.statusCode == 401) {
      throw ProxyException('This device is no longer paired. Pair again from the desktop.');
    }
    if (res.statusCode == 403) {
      throw ProxyException('That action is not permitted from the app.');
    }
    if (res.statusCode != 200) {
      throw ProxyException('Request failed (error ${res.statusCode}).');
    }
    final body = jsonDecode(res.body) as Map<String, dynamic>;
    return ((body[key] as List<dynamic>?) ?? const []).cast<Map<String, dynamic>>();
  }

  Future<List<Map<String, dynamic>>> getTrackers(PairingCredentials c) =>
      _getList(c, '/ep/trackers', 'trackers');
  Future<List<Map<String, dynamic>>> getShipments(PairingCredentials c) =>
      _getList(c, '/ep/shipments', 'shipments');
  Future<List<Map<String, dynamic>>> getInsurances(PairingCredentials c) =>
      _getList(c, '/ep/insurances', 'insurances');
  Future<List<Map<String, dynamic>>> getClaims(PairingCredentials c) =>
      _getList(c, '/ep/claims', 'claims');
  Future<List<Map<String, dynamic>>> getPickups(PairingCredentials c) =>
      _getList(c, '/ep/pickups', 'pickups');
}
