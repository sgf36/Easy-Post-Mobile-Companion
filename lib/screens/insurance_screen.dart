import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';
import '../models/tracker.dart';
import '../services/error_text.dart';
import '../services/pairing_store.dart';
import '../services/proxy_client.dart';
import '../theme.dart';
import 'home_shell.dart';
import 'resource_detail_screen.dart';

class InsuranceScreen extends StatefulWidget {
  final AppNav nav;
  final PairingCredentials creds;
  const InsuranceScreen({super.key, required this.nav, required this.creds});

  @override
  State<InsuranceScreen> createState() => _InsuranceScreenState();
}

class _InsuranceScreenState extends State<InsuranceScreen> {
  final _proxy = ProxyClient();
  late Future<List<Map<String, dynamic>>> _future;

  @override
  void initState() {
    super.initState();
    _future = _proxy.getInsurances(widget.creds);
  }

  Future<void> _refresh() async {
    final f = _proxy.getInsurances(widget.creds);
    setState(() => _future = f);
    await f.catchError((_) => <Map<String, dynamic>>[]);
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(t.navInsurance)),
      drawer: NavDrawer(nav: widget.nav),
      // Buying insurance is deliberately absent on mobile. Apple rejected 1.0
      // under guideline 5.1.1(ix): purchasing insurance and filing claims are
      // "highly regulated services", which App Review only permits from a
      // Developer Program account enrolled as an organization. This screen is
      // therefore read-only — it shows cover bought on the desktop application,
      // and nothing here can create a policy. Do not reintroduce a purchase
      // action without the organization enrolment in place first.
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: FutureBuilder<List<Map<String, dynamic>>>(
          future: _future,
          builder: (context, snap) {
            if (snap.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snap.hasError) {
              return ListView(children: [Padding(padding: const EdgeInsets.all(24), child: Text(describeError(t, snap.error), textAlign: TextAlign.center))]);
            }
            final items = snap.data ?? const [];
            if (items.isEmpty) {
              return ListView(children: [Padding(padding: const EdgeInsets.all(24), child: Text(t.insuranceEmpty, textAlign: TextAlign.center))]);
            }
            return ListView.separated(
              itemCount: items.length,
              separatorBuilder: (_, _) => const Divider(height: 1),
              itemBuilder: (context, i) {
                final m = items[i];
                final heading = (m['tracking_code'] ?? m['id'] ?? '—').toString();
                return ListTile(
                  title: Text(heading, style: const TextStyle(fontWeight: FontWeight.w600)),
                  subtitle: Text((m['provider'] ?? m['carrier'] ?? '').toString()),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(formatMoney(m['amount'],
                          currency: (m['currency'] ?? 'USD').toString(),
                          locale: t.localeName)),
                      const Padding(
                        padding: EdgeInsetsDirectional.only(start: 4),
                        child: Icon(Icons.chevron_right, size: 20, color: Brand.muted),
                      ),
                    ],
                  ),
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => ResourceDetailScreen(
                        title: t.detailInsurancePolicy,
                        heading: heading,
                        fields: [
                          DetailField(t.fieldStatus, statusText(t, m['status'])),
                          DetailField(t.fieldProvider,
                              (m['provider'] ?? m['carrier'] ?? '').toString()),
                          DetailField(
                            t.fieldAmount,
                            formatMoney(m['amount'],
                                currency: (m['currency'] ?? 'USD').toString(),
                                locale: t.localeName),
                          ),
                          DetailField(
                            t.fieldCost,
                            formatMoney(m['fee'],
                                currency: (m['currency'] ?? 'USD').toString(),
                                locale: t.localeName),
                          ),
                          DetailField(t.insuranceFromAddress, formatAddress(m['from_address'])),
                          DetailField(t.insuranceToAddress, formatAddress(m['to_address'])),
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
              },
            );
          },
        ),
      ),
    );
  }
}
