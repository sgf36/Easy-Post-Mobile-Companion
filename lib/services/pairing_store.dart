import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// What a paired phone holds: a long-lived device token and the key-encryption
/// key (KEK) that lets the proxy decrypt this account's EasyPost key for one
/// request. Never the raw EasyPost key. Stored in the OS secure enclave
/// (iOS Keychain / Android Keystore) via flutter_secure_storage.
class PairingCredentials {
  final String deviceToken;
  final String kek;
  final String proxyUrl;

  const PairingCredentials({
    required this.deviceToken,
    required this.kek,
    required this.proxyUrl,
  });
}

class PairingStore {
  static const _storage = FlutterSecureStorage();
  static const _kDevice = 'device_token';
  static const _kKek = 'kek';
  static const _kProxy = 'proxy_url';

  /// Device tokens whose revoke the proxy has not yet confirmed.
  ///
  /// Kept apart from the pairing keys, so that [clear] leaves it alone: an
  /// unpair made offline must still be able to reach the proxy afterwards,
  /// when the pairing itself is long gone. Kept in the secure store rather than
  /// in preferences because each entry is still a live bearer token.
  static const _kPendingRevokes = 'pending_revokes';

  Future<PairingCredentials?> load() async {
    final token = await _storage.read(key: _kDevice);
    final kek = await _storage.read(key: _kKek);
    final proxy = await _storage.read(key: _kProxy);
    if (token == null || kek == null || proxy == null) return null;
    return PairingCredentials(deviceToken: token, kek: kek, proxyUrl: proxy);
  }

  Future<void> save(PairingCredentials c) async {
    await _storage.write(key: _kDevice, value: c.deviceToken);
    await _storage.write(key: _kKek, value: c.kek);
    await _storage.write(key: _kProxy, value: c.proxyUrl);
  }

  Future<void> clear() async {
    await _storage.delete(key: _kDevice);
    await _storage.delete(key: _kKek);
    await _storage.delete(key: _kProxy);
  }

  /// Every revoke still owed, oldest first.
  ///
  /// An unreadable entry is dropped rather than thrown: a corrupt queue must
  /// not stop the app opening, and a token nobody can read back is a token
  /// nobody can present either.
  Future<List<PendingRevoke>> pendingRevokes() async {
    final raw = await _storage.read(key: _kPendingRevokes);
    if (raw == null || raw.isEmpty) return const [];
    try {
      return [
        for (final e in jsonDecode(raw) as List<dynamic>)
          if (e is Map &&
              e['device_token'] is String &&
              e['proxy_url'] is String)
            PendingRevoke(
              deviceToken: e['device_token'] as String,
              proxyUrl: e['proxy_url'] as String,
            ),
      ];
    } catch (_) {
      return const [];
    }
  }

  /// Remember that [deviceToken] must be revoked. Adding a token already queued
  /// changes nothing, so unpairing twice cannot queue it twice.
  Future<void> queueRevoke(String proxyUrl, String deviceToken) async {
    final list = await pendingRevokes();
    if (list.any((p) => p.deviceToken == deviceToken)) return;
    await _writePending([
      ...list,
      PendingRevoke(deviceToken: deviceToken, proxyUrl: proxyUrl),
    ]);
  }

  /// Forget [deviceToken] once the proxy has confirmed it is revoked.
  Future<void> removePendingRevoke(String deviceToken) async {
    final list = await pendingRevokes();
    final kept = list.where((p) => p.deviceToken != deviceToken).toList();
    if (kept.length == list.length) return;
    await _writePending(kept);
  }

  Future<void> _writePending(List<PendingRevoke> list) async {
    if (list.isEmpty) {
      await _storage.delete(key: _kPendingRevokes);
      return;
    }
    await _storage.write(
      key: _kPendingRevokes,
      value: jsonEncode([
        for (final p in list)
          {'device_token': p.deviceToken, 'proxy_url': p.proxyUrl},
      ]),
    );
  }
}

/// A device token the proxy still has to be told to revoke, and where to tell
/// it. The KEK is deliberately not kept: revoking needs only the token.
class PendingRevoke {
  final String deviceToken;
  final String proxyUrl;

  const PendingRevoke({required this.deviceToken, required this.proxyUrl});
}
