import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../config.dart';
import '../l10n/app_localizations.dart';
import '../services/error_text.dart';
import '../services/pairing_store.dart';
import '../services/proxy_client.dart';

/// Scans the pairing QR shown by Easy-Post Desktop (or takes a reviewer code)
/// and hands back the resulting credentials.
class PairScreen extends StatefulWidget {
  final Future<void> Function(PairingCredentials) onPaired;
  const PairScreen({super.key, required this.onPaired});

  @override
  State<PairScreen> createState() => _PairScreenState();
}

class _PairScreenState extends State<PairScreen> {
  final MobileScannerController _scanner = MobileScannerController();
  final ProxyClient _proxy = ProxyClient();
  bool _busy = false;
  bool _handled = false;

  @override
  void dispose() {
    _scanner.dispose();
    super.dispose();
  }

  Future<void> _onDetect(BarcodeCapture capture) async {
    if (_handled || _busy || capture.barcodes.isEmpty) return;
    final raw = capture.barcodes.first.rawValue;
    if (raw == null) return;
    Map<String, dynamic> data;
    try {
      data = jsonDecode(raw) as Map<String, dynamic>;
    } catch (_) {
      return; // not one of our QR codes; keep scanning
    }
    final token = data['t'] as String?;
    final url = (data['u'] as String?) ?? Config.defaultProxyUrl;
    if (token == null) return;
    _handled = true;
    await _pair(() => _proxy.claim(url, token));
  }

  Future<void> _pair(Future<PairingCredentials> Function() action) async {
    final t = AppLocalizations.of(context);
    setState(() => _busy = true);
    try {
      final creds = await action();
      await widget.onPaired(creds);
    } catch (e) {
      _handled = false;
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(describeError(t, e))));
      }
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _enterReviewCode() async {
    final t = AppLocalizations.of(context);
    final controller = TextEditingController();
    final code = await showDialog<String>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(t.pairReviewDialogTitle),
        content: TextField(
          controller: controller,
          autofocus: true,
          decoration: InputDecoration(hintText: t.pairReviewCodeHint),
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx), child: Text(t.actionCancel)),
          FilledButton(
              onPressed: () => Navigator.pop(ctx, controller.text.trim()),
              child: Text(t.pairAction)),
        ],
      ),
    );
    if (code == null || code.isEmpty) return;
    await _pair(() => _proxy.demo(Config.defaultProxyUrl, code));
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(t.pairTitle)),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Row(
              children: [
                Image.asset('assets/icon/app_icon.png', height: 44, width: 44),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(t.appTitle,
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
            child: Text(t.pairInstructions),
          ),
          Expanded(
            child: Stack(
              alignment: Alignment.center,
              children: [
                MobileScanner(controller: _scanner, onDetect: _onDetect),
                if (_busy) const CircularProgressIndicator(),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextButton(
              onPressed: _busy ? null : _enterReviewCode,
              child: Text(t.pairEnterReviewCode),
            ),
          ),
        ],
      ),
    );
  }
}
