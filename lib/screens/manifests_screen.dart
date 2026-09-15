import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';
import '../models/tracker.dart';
import '../services/error_text.dart';
import '../services/pairing_store.dart';
import '../services/proxy_client.dart';
import '../theme.dart';
import 'home_shell.dart';

class ManifestsScreen extends StatefulWidget {
  final AppNav nav;
  final PairingCredentials creds;
  final ProxyClient proxy;
  const ManifestsScreen(
      {super.key, required this.nav, required this.creds, required this.proxy});

  @override
  State<ManifestsScreen> createState() => _ManifestsScreenState();
}

class _ManifestsScreenState extends State<ManifestsScreen> {
  ProxyClient get _proxy => widget.proxy;
  late Future<List<Map<String, dynamic>>> _future;

  @override
  void initState() {
    super.initState();
    _future = _proxy.getScanForms(widget.creds);
  }

  Future<void> _refresh() async {
    final f = _proxy.getScanForms(widget.creds);
    setState(() => _future = f);
    await f.catchError((_) => <Map<String, dynamic>>[]);
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(t.navManifests)),
      drawer: NavDrawer(nav: widget.nav),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: FutureBuilder<List<Map<String, dynamic>>>(
          future: _future,
          builder: (context, snap) {
            if (snap.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snap.hasError) {
              return ListView(children: [
                Padding(
                    padding: const EdgeInsets.all(24),
                    child: Text(describeError(t, snap.error),
                        textAlign: TextAlign.center)),
              ]);
            }
            final items = snap.data ?? const [];
            if (items.isEmpty) {
              return ListView(children: [
                Padding(
                    padding: const EdgeInsets.all(24),
                    child: Text(t.manifestsEmpty,
                        textAlign: TextAlign.center)),
              ]);
            }
            return ListView.separated(
              itemCount: items.length,
              separatorBuilder: (_, __) => const Divider(height: 1),
              itemBuilder: (context, i) => _tile(context, items[i]),
            );
          },
        ),
      ),
    );
  }

  Widget _tile(BuildContext context, Map<String, dynamic> m) {
    final t = AppLocalizations.of(context);
    final id = (m['id'] ?? '').toString();
    final status = (m['status'] ?? '').toString();
    final codes = _trackingCodes(m);
    final address = formatAddress(m['address']);
    final created = formatDateTime(
        DateTime.tryParse((m['created_at'] ?? '').toString()), t.localeName);

    return ListTile(
      title: Text(
        '${codes.length} ${codes.length == 1 ? t.manifestShipmentSingular : t.manifestShipmentPlural}',
        style: const TextStyle(fontWeight: FontWeight.w600),
      ),
      subtitle: Text(
        address.isNotEmpty ? '$address\n$created' : created,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
      isThreeLine: address.isNotEmpty,
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _statusChip(t, status),
          const Padding(
            padding: EdgeInsetsDirectional.only(start: 4),
            child: Icon(Icons.chevron_right, size: 20, color: Brand.muted),
          ),
        ],
      ),
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => _ManifestDetailScreen(manifest: m)),
      ),
    );
  }

  Widget _statusChip(AppLocalizations t, String status) {
    final Color bg;
    final String label;
    switch (status) {
      case 'created':
        bg = Colors.green.shade50;
        label = t.manifestStatusCreated;
      case 'creating':
        bg = Colors.orange.shade50;
        label = t.manifestStatusCreating;
      case 'failed':
        bg = Colors.red.shade50;
        label = t.manifestStatusFailed;
      default:
        bg = Colors.grey.shade100;
        label = status;
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(label, style: const TextStyle(fontSize: 12)),
    );
  }
}

List<String> _trackingCodes(Map<String, dynamic> m) {
  final raw = m['tracking_codes'];
  if (raw is List) return raw.map((e) => e.toString()).toList();
  if (raw is String && raw.isNotEmpty) return raw.split(',');
  return [];
}

class _ManifestDetailScreen extends StatelessWidget {
  final Map<String, dynamic> manifest;
  const _ManifestDetailScreen({required this.manifest});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    final confirmation = (manifest['confirmation'] ?? '').toString();
    final codes = _trackingCodes(manifest);
    final address = formatAddress(manifest['address']);
    final status = (manifest['status'] ?? '').toString();
    final created = formatDateTime(
        DateTime.tryParse((manifest['created_at'] ?? '').toString()),
        t.localeName);

    return Scaffold(
      appBar: AppBar(title: Text(t.detailManifest)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          if (confirmation.isNotEmpty) ...[
            Card(
              elevation: 0,
              color: Brand.background,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Text(t.manifestBarcodeHeading,
                        style: const TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 14)),
                    const SizedBox(height: 16),
                    BarcodeWidget(
                      barcode: Barcode.code128(),
                      data: confirmation,
                      width: double.infinity,
                      height: 80,
                      drawText: true,
                      style: const TextStyle(fontSize: 12),
                    ),
                    const SizedBox(height: 8),
                    Text(t.manifestBarcodeTip,
                        style: TextStyle(
                            fontSize: 12, color: Brand.muted),
                        textAlign: TextAlign.center),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],
          _field(t.fieldStatus, status),
          _field(t.manifestFieldAddress, address),
          _field(t.fieldCreated, created),
          const SizedBox(height: 12),
          Text(t.manifestTrackingCodesHeading,
              style:
                  const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
          const SizedBox(height: 8),
          ...codes.map((code) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 2),
                child: Text(code,
                    style: const TextStyle(
                        fontFamily: 'monospace', fontSize: 13)),
              )),
          if (codes.isEmpty)
            Text(t.manifestNoTrackingCodes,
                style: TextStyle(color: Brand.muted)),
        ],
      ),
    );
  }

  Widget _field(String label, String value) {
    if (value.isEmpty) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Brand.muted)),
          const SizedBox(height: 2),
          Text(value, style: const TextStyle(fontSize: 15)),
        ],
      ),
    );
  }
}
