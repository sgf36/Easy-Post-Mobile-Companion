import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';
import '../models/spend_report.dart';
import '../models/tracker.dart' show carrierColor, carrierDisplayName;
import '../services/error_text.dart';
import '../services/pairing_store.dart';
import '../services/proxy_client.dart';
import 'home_shell.dart';

/// Reports — a Tools section. Aggregates the shipment history on the device
/// (count and spend, overall and per carrier), mirroring the desktop Reports.
class ReportsScreen extends StatefulWidget {
  final AppNav nav;
  final PairingCredentials creds;
  final ProxyClient proxy;
  const ReportsScreen(
      {super.key, required this.nav, required this.creds, required this.proxy});

  @override
  State<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen> {
  late Future<SpendReport> _future;

  @override
  void initState() {
    super.initState();
    _future = _build();
  }

  /// What counts as spend is decided by [buildSpendReport], not here.
  Future<SpendReport> _build() async =>
      buildSpendReport(await widget.proxy.getShipments(widget.creds));

  Future<void> _refresh() async {
    final f = _build();
    setState(() {
      _future = f;
    });
    await f.catchError((_) => SpendReport());
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(t.navReports)),
      drawer: NavDrawer(nav: widget.nav),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: FutureBuilder<SpendReport>(
          future: _future,
          builder: (context, snap) {
            if (snap.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snap.hasError) {
              return ListView(children: [
                Padding(
                    padding: const EdgeInsets.all(24),
                    child: Text(describeError(t, snap.error), textAlign: TextAlign.center)),
              ]);
            }
            final r = snap.data ?? SpendReport();
            // Ordered by shipment count rather than spend: spend is no longer a
            // single comparable number once more than one currency is in play,
            // and converting between them would need a rate this app has no
            // business inventing.
            final carriers = r.carrierCount.keys.toList()
              ..sort((a, b) => (r.carrierCount[b] ?? 0).compareTo(r.carrierCount[a] ?? 0));
            return ListView(
              padding: const EdgeInsets.all(16),
              children: [
                // Stretch, not the default: a spend figure spanning two
                // currencies wraps to a second line, and with the default
                // alignment the two cards then had visibly different heights.
                IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(child: _card(t.reportsShipments, '${r.count}')),
                      const SizedBox(width: 12),
                      Expanded(
                          child: _card(t.reportsTotalSpend, r.spendLabel(t.localeName))),
                    ],
                  ),
                ),
                // Beside the total rather than subtracted from it: until the
                // carrier settles, the money is spent and may not come back.
                if (r.pendingRefundsByCurrency.isNotEmpty) ...[
                  const SizedBox(height: 12),
                  _card(t.reportsRefundsPending, r.pendingRefundsLabel(t.localeName)),
                ],
                const SizedBox(height: 24),
                Text(t.reportsByCarrier, style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 8),
                if (carriers.isEmpty)
                  Padding(padding: const EdgeInsets.all(16), child: Text(t.reportsEmpty)),
                for (final c in carriers)
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: CircleAvatar(backgroundColor: carrierColor(c), radius: 14),
                    title: Text(c.isEmpty ? t.carrierUnknownShort : carrierDisplayName(c)),
                    subtitle: Text(t.reportsCarrierShipments(r.carrierCount[c] ?? 0)),
                    trailing: Text(r.carrierSpendLabel(c, t.localeName),
                        style: const TextStyle(fontWeight: FontWeight.w600)),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _card(String label, String value) => Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: const TextStyle(color: Colors.grey)),
              const SizedBox(height: 6),
              Text(value, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      );
}
