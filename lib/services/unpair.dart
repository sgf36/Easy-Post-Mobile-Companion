import 'pairing_store.dart';
import 'proxy_client.dart';

/// What an unpair achieved, so the interface can say so honestly.
enum UnpairOutcome {
  /// The proxy confirmed the token is dead. Nothing more to do.
  revoked,

  /// The phone is unpaired locally, but the proxy could not be reached. The
  /// token stays queued and is revoked on a later launch or return to the app.
  revokeQueued,
}

/// Unpairs this phone so that its credentials stop working, not merely so that
/// it forgets them.
///
/// Unpairing used to delete the keychain entries and nothing else. The device
/// token and KEK stayed valid at the proxy indefinitely, so a lost, sold or
/// backed-up phone kept reading every recipient address on the account, while
/// the App Store listing said unpairing revoked access.
class Unpairer {
  final PairingStore store;
  final ProxyClient proxy;

  Unpairer({required this.store, required this.proxy});

  /// Serialises every read-modify-write of the revoke queue. A retry started on
  /// resume can overlap an unpair tapped a moment later, and two unsynchronised
  /// rewrites of one list lose an entry.
  Future<void> _tail = Future<void>.value();

  Future<T> _serial<T>(Future<T> Function() body) {
    final run = _tail.then((_) => body());
    _tail = run.then<void>((_) {}, onError: (_) {});
    return run;
  }

  /// Revoke [creds] at the proxy, then forget them locally.
  ///
  /// The token is queued before the request is sent, not after it fails. If the
  /// app is killed mid-request the revoke is still owed on the next launch;
  /// queueing only on failure would lose it in exactly the case where nobody
  /// is watching. The local wipe happens whatever the proxy says, because a
  /// user who asked to unpair must not be left paired by a dead network.
  Future<UnpairOutcome> unpair(PairingCredentials creds) => _serial(() async {
    await store.queueRevoke(creds.proxyUrl, creds.deviceToken);
    final done = await proxy.revokeToken(creds.proxyUrl, creds.deviceToken);
    if (done) await store.removePendingRevoke(creds.deviceToken);
    await store.clear();
    return done ? UnpairOutcome.revoked : UnpairOutcome.revokeQueued;
  });

  /// Try every queued revoke once. Returns how many are still owed.
  ///
  /// Called at launch and whenever the app returns to the foreground: the app
  /// carries no connectivity listener, and those are the moments a phone that
  /// was offline is most likely to have come back.
  Future<int> retryPending() => _serial(() async {
    var remaining = 0;
    for (final p in await store.pendingRevokes()) {
      if (await proxy.revokeToken(p.proxyUrl, p.deviceToken)) {
        await store.removePendingRevoke(p.deviceToken);
      } else {
        remaining++;
      }
    }
    return remaining;
  });
}
