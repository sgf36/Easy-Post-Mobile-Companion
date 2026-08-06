/// App-wide constants for the Easy-Post Mobile Companion.
class Config {
  /// Fallback pairing/proxy backend. The pairing QR also carries its own proxy
  /// URL ("u"), which takes precedence; this is used for the reviewer demo path
  /// and as a default.
  static const String defaultProxyUrl =
      'https://easypost-mobile-proxy.sgf36.workers.dev';
}
