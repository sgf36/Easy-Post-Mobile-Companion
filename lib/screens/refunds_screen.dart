import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';
import '../models/tracker.dart';
import '../services/error_text.dart';
import '../services/pairing_store.dart';
import '../services/proxy_client.dart';
import '../theme.dart';
import 'home_shell.dart';
import 'resource_detail_screen.dart';

/// Where a refund request has got to.
///
/// Requesting one is the desktop application's job, as buying the label was —
/// this screen answers the question that follows, which is the one a person
/// actually has to keep checking. A carrier settles a refund asynchronously and
/// can take days over it, so "submitted" is a state somebody sits in rather
/// than a moment they pass through, and until now the only way to see it was to
/// go back to the desk.
///
/// Read-only, like the rest of the application since 1.0.1. Nothing here asks
/// for a refund and nothing here cancels one.
class RefundsScreen extends StatefulWidget {
  final AppNav nav;
  final PairingCredentials creds;
  const RefundsScreen({super.key, required this.nav, required this.creds});

  @override
  State<RefundsScreen> createState() => _RefundsScreenState();
}

class _RefundsScreenState extends State<RefundsScreen> {
  final _proxy = ProxyClient();
  late Future<List<Map<String, dynamic>>> _future;

  @override
  void initState() {
    super.initState();
    _future = _load();
  }

  /// Which shipments count as refund requests, and in what order, is decided by
  /// [refundRequests] rather than here — so it can be checked without a screen
  /// and without a network.
  Future<List<Map<String, dynamic>>> _load() async =>
      refundRequests(await _proxy.getShipments(widget.creds));

  Future<void> _refresh() async {
    final f = _load();
    setState(() => _future = f);
    await f.catchError((_) => <Map<String, dynamic>>[]);
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(t.navRefunds)),
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
            if (items.isEmpty) return _message(t.refundsEmpty);
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
    final state = refundStateOf(m);
    final style = refundStatusStyle(state);
    final rate = m['selected_rate'] as Map<String, dynamic>?;
    final heading = (m['tracking_code'] ?? m['id'] ?? '—').toString();
    // The label's own price. Named as a cost rather than as a refunded amount
    // because that is what it is: EasyPost reports whether a request was
    // settled, never what was actually credited, and printing this under
    // "Refunded" would assert a figure nobody sent us.
    final cost = formatMoney(
      rate?['rate'],
      currency: (rate?['currency'] ?? 'USD').toString(),
      locale: t.localeName,
    );

    return ListTile(
      leading: Icon(style.icon, color: style.color),
      title: Text(heading, style: const TextStyle(fontWeight: FontWeight.w600)),
      subtitle: Text(
        [carrierDisplayName((rate?['carrier'] ?? '').toString()), cost]
            .where((p) => p.isNotEmpty)
            .join(' · '),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(refundStatusText(t, state)),
          const Padding(
            padding: EdgeInsetsDirectional.only(start: 4),
            child: Icon(Icons.chevron_right, size: 20, color: Brand.muted),
          ),
        ],
      ),
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => ResourceDetailScreen(
            title: t.detailRefund,
            heading: heading,
            fields: [
              DetailField(t.fieldRefundStatus, refundStatusText(t, state)),
              // The parcel's own status as well, because the two answer
              // different questions and a rejected refund is usually explained
              // by the label having been used.
              DetailField(t.fieldStatus, statusText(t, m['status'])),
              DetailField(t.fieldCarrier,
                  carrierDisplayName((rate?['carrier'] ?? '').toString())),
              DetailField(t.fieldService, (rate?['service'] ?? '').toString()),
              DetailField(t.fieldCost, cost),
              DetailField(t.fieldTrackingCode,
                  (m['tracking_code'] ?? '').toString()),
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
