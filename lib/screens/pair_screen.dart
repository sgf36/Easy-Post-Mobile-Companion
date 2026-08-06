import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../config.dart';
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
    setState(() => _busy = true);
    try {
      final creds = await action();
      await widget.onPaired(creds);
    } catch (e) {
      _handled = false;
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.toString())));
      }
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _enterReviewCode() async {
    final controller = TextEditingController();
    final code = await showDialog<String>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Enter review code'),
        content: TextField(
          controller: controller,
          autofocus: true,
          decoration: const InputDecoration(hintText: 'Review code'),
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
          FilledButton(
              onPressed: () => Navigator.pop(ctx, controller.text.trim()),
              child: const Text('Pair')),
        ],
      ),
    );
    if (code == null || code.isEmpty) return;
    await _pair(() => _proxy.demo(Config.defaultProxyUrl, code));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pair with desktop')),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              'Open Easy-Post Desktop, choose "Pair mobile app", and scan the QR code shown there.',
            ),
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
              child: const Text('Enter review code instead'),
            ),
          ),
        ],
      ),
    );
  }
}
