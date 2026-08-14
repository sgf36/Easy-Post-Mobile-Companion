import 'dart:convert';
import 'dart:io' show Platform;

import 'package:http/http.dart' as http;

import 'demo_fixtures.dart';
import 'pairing_store.dart';

/// What went wrong, rather than what to say about it.
///
/// The client has no `BuildContext` and therefore no localisations, so it names
/// the failure and the UI turns that into a sentence in the reader's language
/// (`describeError` in services/error_text.dart). The one exception is
/// [apiMessage], which carries EasyPost's own wording verbatim: it arrives from
/// the API in English and inventing a translation for it would be inventing the
/// content of somebody else's error.
enum ProxyErrorKind {
  pairingCodeInvalid,
  reviewCodeRejected,
  unexpectedPairingResponse,
  notPaired,
  notPairedShort,
  forbidden,
  requestFailed,
  apiMessage,
}

/// A failure with a message safe to show the user.
class ProxyException implements Exception {
  final ProxyErrorKind kind;

  /// English fallback, used for logs and by [toString].
  final String message;

  /// Set for [ProxyErrorKind.requestFailed]; interpolated into the message.
  final int? statusCode;

  ProxyException(this.kind, this.message, {this.statusCode});

  @override
  String toString() => message;
}

/// Talks to the easypost-mobile-proxy Worker. The phone never holds the raw
/// EasyPost key; it presents its device token + KEK and the proxy decrypts,
/// calls EasyPost, and returns only allow-listed data.
class ProxyClient {
  /// Serve invented data instead of calling the proxy. Screenshots only.
  ///
  /// Compiled in with `--dart-define=DEMO_FIXTURES=true`, so a shipping build
  /// cannot reach this path: the constant folds to false and the fixture
  /// subclass is unreachable. A release build never returns fake shipments.
  static const bool useFixtures =
      bool.fromEnvironment('DEMO_FIXTURES', defaultValue: false);

  /// Screens construct `ProxyClient()` directly, so the swap happens here
  /// rather than by threading an injected client through every widget.
  factory ProxyClient() =>
      useFixtures ? _FixtureProxyClient._() : ProxyClient._real();

  ProxyClient._real();

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
      onFail: ProxyErrorKind.pairingCodeInvalid,
      onFailMessage:
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
    return _asCredentials(
      proxyUrl,
      res,
      onFail: ProxyErrorKind.reviewCodeRejected,
      onFailMessage: 'That review code was not accepted.',
    );
  }

  PairingCredentials _asCredentials(
    String proxyUrl,
    http.Response res, {
    required ProxyErrorKind onFail,
    required String onFailMessage,
  }) {
    if (res.statusCode != 200) throw ProxyException(onFail, onFailMessage);
    final body = jsonDecode(res.body) as Map<String, dynamic>;
    final token = body['device_token'] as String?;
    final kek = body['kek'] as String?;
    if (token == null || kek == null) {
      throw ProxyException(ProxyErrorKind.unexpectedPairingResponse,
          'Unexpected response from the pairing service.');
    }
    return PairingCredentials(deviceToken: token, kek: kek, proxyUrl: proxyUrl);
  }

  Map<String, String> _authHeaders(PairingCredentials c) => {
        'authorization': 'Bearer ${c.deviceToken}',
        'x-ep-kek': c.kek,
      };

  /// EasyPost caps a collection response and reports the rest through
  /// `has_more`; one page is what a bare GET returns.
  static const int _pageSize = 100;

  /// A backstop against walking an implausibly large account, not a display
  /// limit — set far above any small shipper's history. If it is ever reached
  /// the list is short by design rather than by accident.
  static const int _maxItems = 1000;

  /// GET one page of an allow-listed EasyPost collection through the proxy.
  Future<Map<String, dynamic>> _getPage(PairingCredentials c, Uri uri) async {
    final res = await http.get(uri, headers: _authHeaders(c));
    if (res.statusCode == 401) {
      throw ProxyException(ProxyErrorKind.notPaired,
          'This device is no longer paired. Pair again from the desktop.');
    }
    if (res.statusCode == 403) {
      throw ProxyException(
          ProxyErrorKind.forbidden, 'That action is not permitted from the app.');
    }
    if (res.statusCode != 200) {
      throw ProxyException(
        ProxyErrorKind.requestFailed,
        'Request failed (error ${res.statusCode}).',
        statusCode: res.statusCode,
      );
    }
    return jsonDecode(res.body) as Map<String, dynamic>;
  }

  /// Every item in an allow-listed EasyPost collection, not just the first page.
  ///
  /// This was a single unparameterised GET, so it took whatever one page
  /// EasyPost chose to return and dropped the remainder without a word. In the
  /// review account that meant 25 of 54 trackers — and because EasyPost returns
  /// newest first while the app sorts by journey order, the ones that arrived
  /// were the most recent batch, all of them delivered. The app looked like it
  /// could only ever show delivered parcels; in fact it had never been sent the
  /// others.
  ///
  /// A real account fails the same way and worse: a shipper with several
  /// hundred parcels would see a truncated history with nothing on screen
  /// admitting it. Silent truncation reads as "this is everything", so this
  /// follows `has_more` to the end.
  Future<List<Map<String, dynamic>>> _getList(
    PairingCredentials c,
    String path,
    String key,
  ) async {
    final out = <Map<String, dynamic>>[];
    final base = Uri.parse('${c.proxyUrl}$path');
    String? beforeId;
    while (true) {
      final uri = base.replace(queryParameters: <String, String>{
        ...base.queryParameters,
        'page_size': '$_pageSize',
        'before_id': ?beforeId,
      });
      final body = await _getPage(c, uri);
      final items =
          ((body[key] as List<dynamic>?) ?? const []).cast<Map<String, dynamic>>();
      if (items.isEmpty) break;
      out.addAll(items);
      final lastId = items.last['id']?.toString();
      if (body['has_more'] != true || lastId == null || out.length >= _maxItems) {
        break;
      }
      beforeId = lastId;
    }
    return out;
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

  /// POST an allow-listed EasyPost action through the proxy, returning the JSON
  /// body. Surfaces EasyPost's own error message where present.
  Future<Map<String, dynamic>> _post(
    PairingCredentials c,
    String path,
    Map<String, dynamic> body,
  ) async {
    final res = await http.post(
      Uri.parse('${c.proxyUrl}$path'),
      headers: {..._authHeaders(c), 'content-type': 'application/json'},
      body: jsonEncode(body),
    );
    dynamic data;
    try {
      data = res.body.isNotEmpty ? jsonDecode(res.body) : {};
    } catch (_) {
      data = {};
    }
    if (res.statusCode == 401) {
      throw ProxyException(
          ProxyErrorKind.notPairedShort, 'This device is no longer paired.');
    }
    if (res.statusCode == 403) {
      throw ProxyException(
          ProxyErrorKind.forbidden, 'That action is not permitted from the app.');
    }
    if (res.statusCode >= 400) {
      final err = (data is Map && data['error'] is Map) ? data['error']['message'] : null;
      if (err != null) {
        // EasyPost's own wording. Shown as sent rather than paraphrased: it is
        // the only account of what the API objected to.
        throw ProxyException(ProxyErrorKind.apiMessage, err.toString());
      }
      throw ProxyException(
        ProxyErrorKind.requestFailed,
        'Request failed (error ${res.statusCode}).',
        statusCode: res.statusCode,
      );
    }
    return (data is Map) ? data.cast<String, dynamic>() : <String, dynamic>{};
  }

  /// Buy standalone insurance. `insurance` carries tracking_code, carrier,
  /// amount and the to/from addresses.
  Future<Map<String, dynamic>> buyInsurance(PairingCredentials c, Map<String, dynamic> insurance) =>
      _post(c, '/ep/insurances', {'insurance': insurance});

  /// File a claim (fields sent at the top level per the EasyPost claims API).
  Future<Map<String, dynamic>> fileClaim(PairingCredentials c, Map<String, dynamic> claim) =>
      _post(c, '/ep/claims', claim);

  /// Cancel a scheduled pickup.
  Future<Map<String, dynamic>> cancelPickup(PairingCredentials c, String id) =>
      _post(c, '/ep/pickups/$id/cancel', const {});
}

/// Returns the invented shot-list data instead of calling the proxy.
///
/// Reachable only under `--dart-define=DEMO_FIXTURES=true`; see
/// [ProxyClient.useFixtures]. Every getter is overridden, so a screen added
/// later that forgets about fixtures cannot silently fall through to the live
/// account — it would call an inherited method needing credentials the capture
/// run does not have, and fail loudly rather than photograph real shipments.
class _FixtureProxyClient extends ProxyClient {
  _FixtureProxyClient._() : super._real();

  /// A beat of latency so the screens' loading states resolve the way they do
  /// against the network, rather than painting before the first frame settles.
  Future<List<Map<String, dynamic>>> _canned(List<Map<String, dynamic>> rows) async {
    await Future<void>.delayed(const Duration(milliseconds: 120));
    return rows;
  }

  @override
  Future<List<Map<String, dynamic>>> getTrackers(PairingCredentials c) =>
      _canned(demoTrackers);

  @override
  Future<List<Map<String, dynamic>>> getShipments(PairingCredentials c) =>
      _canned(demoShipments);

  @override
  Future<List<Map<String, dynamic>>> getInsurances(PairingCredentials c) =>
      _canned(demoInsurances);

  @override
  Future<List<Map<String, dynamic>>> getClaims(PairingCredentials c) =>
      _canned(demoClaims);

  @override
  Future<List<Map<String, dynamic>>> getPickups(PairingCredentials c) =>
      _canned(demoPickups);
}
