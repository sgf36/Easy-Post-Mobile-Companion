import 'package:flutter/material.dart';

import '../models/tracker.dart' show carrierColor, carrierDisplayName;
import '../services/pairing_store.dart';
import '../services/proxy_client.dart';
import 'home_shell.dart';

/// Reports — a Tools section. Aggregates the shipment history on the device
/// (count and spend, overall and per carrier), mirroring the desktop Reports.
class ReportsScreen extends StatefulWidget {
  final AppNav nav;
  final PairingCredentials creds;
  const ReportsScreen({super.key, required this.nav, required this.creds});

  @override
  State<ReportsScreen> createState() => _ReportsScreenState();
}

class _Report {
  int count = 0;
  double spend = 0;
  String currency = '';
  final Map<String, int> carrierCount = {};
  final Map<String, double> carrierSpend = {};
}

class _ReportsScreenState extends State<ReportsScreen> {
  late Future<_Report> _future;

  @override
  void initState() {
    super.initState();
    _future = _build();
  }

  Future<_Report> _build() async {
    final shipments = await ProxyClient().getShipments(widget.creds);
    final r = _Report();
    for (final s in shipments) {
      r.count++;
      final rate = s['selected_rate'];
      if (rate is Map) {
        final amount = double.tryParse('${rate['rate'] ?? ''}') ?? 0;
        final carrier = (rate['carrier'] ?? 'Unknown').toString();
        r.spend += amount;
        if (r.currency.isEmpty) r.currency = (rate['currency'] ?? '').toString();
        r.carrierCount[carrier] = (r.carrierCount[carrier] ?? 0) + 1;
        r.carrierSpend[carrier] = (r.carrierSpend[carrier] ?? 0) + amount;
      }
    }
    return r;
  }

  Future<void> _refresh() async {
    final f = _build();
    setState(() => _future = f);
    await f.catchError((_) => _Report());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Reports')),
      drawer: NavDrawer(nav: widget.nav),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: FutureBuilder<_Report>(
          future: _future,
          builder: (context, snap) {
            if (snap.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snap.hasError) {
              return ListView(children: [
                Padding(padding: const EdgeInsets.all(24), child: Text('${snap.error}', textAlign: TextAlign.center)),
              ]);
            }
            final r = snap.data ?? _Report();
            final carriers = r.carrierCount.keys.toList()
              ..sort((a, b) => (r.carrierSpend[b] ?? 0).compareTo(r.carrierSpend[a] ?? 0));
            final cur = r.currency.isEmpty ? '' : ' ${r.currency}';
            return ListView(
              padding: const EdgeInsets.all(16),
              children: [
                Row(
                  children: [
                    Expanded(child: _card('Shipments', '${r.count}')),
                    const SizedBox(width: 12),
                    Expanded(child: _card('Total spend', '${r.spend.toStringAsFixed(2)}$cur')),
                  ],
                ),
                const SizedBox(height: 24),
                Text('By carrier', style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 8),
                if (carriers.isEmpty)
                  const Padding(padding: EdgeInsets.all(16), child: Text('No purchased shipments to report yet.')),
                for (final c in carriers)
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: CircleAvatar(backgroundColor: carrierColor(c), radius: 14),
                    title: Text(c.isEmpty ? 'Unknown' : carrierDisplayName(c)),
                    subtitle: Text('${r.carrierCount[c]} shipment(s)'),
                    trailing: Text('${(r.carrierSpend[c] ?? 0).toStringAsFixed(2)}$cur',
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
