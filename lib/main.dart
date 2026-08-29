import 'package:flutter/material.dart';

import 'l10n/app_localizations.dart';
import 'screens/home_shell.dart';
import 'screens/pair_screen.dart';
import 'services/pairing_store.dart';
import 'services/review_prompt.dart';
import 'theme.dart';

void main() => runApp(const CompanionApp());

class CompanionApp extends StatelessWidget {
  /// Injected only by tests, which must never reach the real store SDK.
  final ReviewPrompt? reviewPrompt;

  const CompanionApp({super.key, this.reviewPrompt});

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
      home: RootGate(reviewPrompt: reviewPrompt),
    );
  }
}

/// Decides the start screen from stored pairing: pair if none, else trackers.
class RootGate extends StatefulWidget {
  final ReviewPrompt? reviewPrompt;

  const RootGate({super.key, this.reviewPrompt});

  @override
  State<RootGate> createState() => _RootGateState();
}

class _RootGateState extends State<RootGate> with WidgetsBindingObserver {
  final PairingStore _store = PairingStore();
  PairingCredentials? _creds;
  bool _loading = true;

  /// The rating ask lives here rather than in a screen because it is armed in
  /// one visit and spent in the next: it has to outlive whatever was on screen
  /// when it was earned. See [ReviewPrompt].
  late final ReviewPrompt _review =
      widget.reviewPrompt ?? StoreReviewPrompt();

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
    if (state == AppLifecycleState.resumed && _creds != null) _review.maybeAsk();
  }

  Future<void> _load() async {
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
    setState(() => _creds = creds);
  }

  Future<void> _unpair() async {
    await _store.clear();
    if (!mounted) return;
    setState(() => _creds = null);
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    final creds = _creds;
    if (creds == null) return PairScreen(onPaired: _onPaired);
    return HomeShell(creds: creds, onUnpair: _unpair, review: _review);
  }
}
