import 'package:flutter/material.dart';

import 'screens/pair_screen.dart';
import 'screens/trackers_screen.dart';
import 'services/pairing_store.dart';
import 'theme.dart';

void main() => runApp(const CompanionApp());

class CompanionApp extends StatelessWidget {
  const CompanionApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Easy-Post Mobile Companion',
      debugShowCheckedModeBanner: false,
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
    return TrackersScreen(creds: creds, onUnpair: _unpair);
  }
}
