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
}
