import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';
import '../models/tracker.dart';
import '../services/error_text.dart';
import '../services/pairing_store.dart';
import '../services/proxy_client.dart';
import '../theme.dart';
import 'home_shell.dart';
import 'resource_detail_screen.dart';

class ClickDropScreen extends StatefulWidget {
  final AppNav nav;
  final PairingCredentials creds;
  final ProxyClient proxy;
  const ClickDropScreen(
      {super.key, required this.nav, required this.creds, required this.proxy});

  @override
  State<ClickDropScreen> createState() => _ClickDropScreenState();
}

class _ClickDropScreenState extends State<ClickDropScreen> {
  ProxyClient get _proxy => widget.proxy;
  late Future<List<Map<String, dynamic>>> _future;

  @override
  void initState() {
    super.initState();
    _future = _proxy.getClickDropOrders(widget.creds);
  }

  Future<void> _refresh() async {
    final f = _proxy.getClickDropOrders(widget.creds);
    setState(() {
      _future = f;
    });
    await f.catchError((_) => <Map<String, dynamic>>[]);
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(t.navClickDrop)),
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
              return _message(describeError(t, snap.error));
            }
            final items = snap.data ?? const [];
            if (items.isEmpty) return _message(t.clickDropEmpty);
            return ListView.separated(
              itemCount: items.length,
              separatorBuilder: (_, _) => const Divider(height: 1),
              itemBuilder: (context, i) => _row(t, items[i]),
            );
          },
        ),
      ),
    );
  }

  Widget _message(String text) => ListView(children: [
        Padding(
          padding: const EdgeInsets.all(24),
          child: Text(text, textAlign: TextAlign.center),
        ),
      ]);

  Widget _row(AppLocalizations t, Map<String, dynamic> m) {
    final status = (m['status'] ?? '').toString();
    final voided = status == 'voided';
    final tracking = (m['tracking_number'] ?? '').toString();
    final orderId = m['order_identifier']?.toString() ?? '';
    final service = (m['service_name'] ?? '').toString();
    final heading = tracking.isNotEmpty ? tracking : '#$orderId';

    return ListTile(
      leading: Icon(
        voided ? Icons.cancel_outlined : Icons.local_post_office,
        color: voided ? Brand.muted : Brand.accent,
      ),
      title: Text(heading, style: const TextStyle(fontWeight: FontWeight.w600)),
      subtitle: Text(service),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(voided ? t.clickDropStatusVoided : t.clickDropStatusPurchased),
          const Padding(
            padding: EdgeInsetsDirectional.only(start: 4),
            child: Icon(Icons.chevron_right, size: 20, color: Brand.muted),
          ),
        ],
      ),
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => ResourceDetailScreen(
            title: t.detailClickDrop,
            heading: heading,
            fields: [
              DetailField(t.fieldStatus,
                  voided ? t.clickDropStatusVoided : t.clickDropStatusPurchased),
              DetailField(t.fieldOrderId, orderId),
              DetailField(t.fieldService, service),
              if (tracking.isNotEmpty)
                DetailField(t.fieldTrackingCode, tracking),
              if ((m['order_reference'] ?? '').toString().isNotEmpty)
                DetailField(
                    t.fieldOrderReference, m['order_reference'].toString()),
              DetailField(
                t.fieldCreated,
                formatDateTime(
                    DateTime.tryParse((m['created_at'] ?? '').toString()),
                    t.localeName),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
