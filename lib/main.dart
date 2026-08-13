import 'package:flutter/material.dart';

import 'l10n/app_localizations.dart';
import 'screens/home_shell.dart';
import 'screens/pair_screen.dart';
import 'services/pairing_store.dart';
import 'theme.dart';

void main() => runApp(const CompanionApp());

class CompanionApp extends StatelessWidget {
  const CompanionApp({super.key});

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
      home: const RootGate(),
    );
  }
}

/// Decides the start screen from stored pairing: pair if none, else trackers.
class RootGate extends StatefulWidget {
  const RootGate({super.key});

  @override
  State<RootGate> createState() => _RootGateState();
}

class _RootGateState extends State<RootGate> {
  final PairingStore _store = PairingStore();
  PairingCredentials? _creds;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _load();
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
    return HomeShell(creds: creds, onUnpair: _unpair);
  }
}
