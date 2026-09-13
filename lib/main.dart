import 'package:flutter/material.dart';

import 'l10n/app_localizations.dart';
import 'screens/home_shell.dart';
import 'screens/pair_screen.dart';
import 'screens/pairing_lost_screen.dart';
import 'services/pairing_store.dart';
import 'services/proxy_client.dart';
import 'services/review_prompt.dart';
import 'services/unpair.dart';
import 'theme.dart';

void main() => runApp(const CompanionApp());

class CompanionApp extends StatelessWidget {
  /// Injected only by tests, which must never reach the real store SDK.
  final ReviewPrompt? reviewPrompt;

  /// Injected only by tests, which must never reach the real proxy.
  final ProxyClient? proxy;

  const CompanionApp({super.key, this.reviewPrompt, this.proxy});

  /// Pins the interface language, for screenshot capture only.
  ///
  /// Compiled in with `--dart-define=UI_LOCALE=de`; left undefined it folds to
  /// an empty string and the app follows the device, which is what a shipping
  /// build does. The capture needs this because a simulator's language cannot
  /// be changed from inside the test that drives the widget tree.
  static const String _forcedLocale = String.fromEnvironment('UI_LOCALE');

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateTitle: (context) => AppLocalizations.of(context).appTitle,
      debugShowCheckedModeBanner: false,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: _forcedLocale.isEmpty ? null : Locale(_forcedLocale),
      theme: Brand.theme(),
      home: RootGate(reviewPrompt: reviewPrompt, proxy: proxy),
    );
  }
}

/// Decides the start screen from stored pairing: pair if none, else trackers.
class RootGate extends StatefulWidget {
  final ReviewPrompt? reviewPrompt;
  final ProxyClient? proxy;

  const RootGate({super.key, this.reviewPrompt, this.proxy});

  @override
  State<RootGate> createState() => _RootGateState();
}

class _RootGateState extends State<RootGate> with WidgetsBindingObserver {
  final PairingStore _store = PairingStore();
  PairingCredentials? _creds;
  bool _loading = true;

  /// Set when the proxy refuses this phone's credentials. Kept as state rather
  /// than acted on at once, so the user sees why they are being asked to pair
  /// instead of finding the scanner in place of their parcels.
  bool _pairingLost = false;

  /// One unpair at a time; a second tap while the first is waiting on the
  /// network would otherwise queue and clear the same pairing twice.
  bool _unpairing = false;

  /// One client for the whole shell, so that a 401 from any section reaches
  /// [_onPairingLost].
  late final ProxyClient _proxy = (widget.proxy ?? ProxyClient())
    ..onPairingLost = _onPairingLost;

  late final Unpairer _unpairer = Unpairer(store: _store, proxy: _proxy);

  /// The rating ask lives here rather than in a screen because it is armed in
  /// one visit and spent in the next: it has to outlive whatever was on screen
  /// when it was earned. See [ReviewPrompt].
  late final ReviewPrompt _review = widget.reviewPrompt ?? StoreReviewPrompt();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _load();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  /// Coming back to the app is one of the two moments the prompt may appear;
  /// a successful tracker load is the other. Neither can fire on the day the
  /// ask was earned — [ReviewPrompt] enforces that itself, so adding a call
  /// site cannot reintroduce the interruption.
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state != AppLifecycleState.resumed) return;
    _unpairer.retryPending();
    if (_creds != null) _review.maybeAsk();
  }

  Future<void> _load() async {
    // Not awaited: a revoke owed from an offline unpair must not hold the app
    // on a spinner, and failing again simply leaves it queued.
    _unpairer.retryPending();
    final creds = await _store.load();
    if (!mounted) return;
    setState(() {
      _creds = creds;
      _loading = false;
    });
  }

  Future<void> _onPaired(PairingCredentials creds) async {
    await _store.save(creds);
    if (!mounted) return;
    setState(() {
      _creds = creds;
      _pairingLost = false;
    });
  }

  void _onPairingLost() {
    if (!mounted || _creds == null || _pairingLost) return;
    setState(() => _pairingLost = true);
  }

  /// Unpair from the drawer, or "Pair again" after the proxy refused us.
  ///
  /// The second still revokes. A 401 can mean the KEK no longer matches while
  /// the token itself is live, and revoking needs only the token.
  Future<void> _unpair() async {
    final creds = _creds;
    if (creds == null || _unpairing) return;
    _unpairing = true;
    final messenger = ScaffoldMessenger.maybeOf(context);
    final t = AppLocalizations.of(context);
    try {
      final outcome = await _unpairer.unpair(creds);
      if (outcome == UnpairOutcome.revokeQueued) {
        messenger?.showSnackBar(
          SnackBar(
            content: Text(t.unpairRevokeQueued),
            duration: const Duration(seconds: 8),
          ),
        );
      }
    } finally {
      _unpairing = false;
    }
    if (!mounted) return;
    setState(() {
      _creds = null;
      _pairingLost = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    final creds = _creds;
    if (creds == null) return PairScreen(onPaired: _onPaired);
    if (_pairingLost) return PairingLostScreen(onPairAgain: _unpair);
    return HomeShell(
      creds: creds,
      onUnpair: _unpair,
      review: _review,
      proxy: _proxy,
    );
  }
}
