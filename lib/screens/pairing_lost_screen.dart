import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';
import '../theme.dart';

/// Shown in place of every section once the proxy refuses this phone.
///
/// A 401 used to arrive as an error in whichever section asked, and then again
/// in the next one, each saying "pair again from the desktop" with no button to
/// do it and Unpair hidden in the drawer. One screen with one action says what
/// actually happened: the phone is no longer paired.
class PairingLostScreen extends StatefulWidget {
  final Future<void> Function() onPairAgain;

  const PairingLostScreen({super.key, required this.onPairAgain});

  @override
  State<PairingLostScreen> createState() => _PairingLostScreenState();
}

class _PairingLostScreenState extends State<PairingLostScreen> {
  bool _busy = false;

  Future<void> _pairAgain() async {
    setState(() => _busy = true);
    try {
      await widget.onPairAgain();
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(32),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.link_off, size: 56, color: Brand.muted),
                const SizedBox(height: 16),
                Text(
                  t.pairingLostTitle,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 12),
                Text(t.pairingLostBody, textAlign: TextAlign.center),
                const SizedBox(height: 24),
                FilledButton.icon(
                  onPressed: _busy ? null : _pairAgain,
                  icon: _busy
                      ? const SizedBox(
                          height: 18,
                          width: 18,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Icon(Icons.qr_code_scanner),
                  label: Text(t.pairingLostAction),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
