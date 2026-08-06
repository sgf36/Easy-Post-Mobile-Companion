import 'package:flutter_test/flutter_test.dart';
import 'package:easypost_mobile_companion/services/pairing_store.dart';

void main() {
  test('PairingCredentials carries the paired device data', () {
    const c = PairingCredentials(
      deviceToken: 'dev-token',
      kek: 'kek-value',
      proxyUrl: 'https://easypost-mobile-proxy.sgf36.workers.dev',
    );
    expect(c.deviceToken, 'dev-token');
    expect(c.kek, 'kek-value');
    expect(c.proxyUrl, startsWith('https://'));
  });
}
