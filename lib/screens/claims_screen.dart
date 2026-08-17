import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';
import '../models/tracker.dart';
import '../services/error_text.dart';
import '../services/pairing_store.dart';
import '../services/proxy_client.dart';
import '../theme.dart';
import 'home_shell.dart';
import 'resource_detail_screen.dart';

class ClaimsScreen extends StatefulWidget {
  final AppNav nav;
  final PairingCredentials creds;
  const ClaimsScreen({super.key, required this.nav, required this.creds});

  @override
  State<ClaimsScreen> createState() => _ClaimsScreenState();
}

class _ClaimsScreenState extends State<ClaimsScreen> {
  final _proxy = ProxyClient();
  late Future<List<Map<String, dynamic>>> _future;

  @override
  void initState() {
    super.initState();
    _future = _proxy.getClaims(widget.creds);
  }

  Future<void> _refresh() async {
    final f = _proxy.getClaims(widget.creds);
    setState(() => _future = f);
    await f.catchError((_) => <Map<String, dynamic>>[]);
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(t.navClaims)),
      drawer: NavDrawer(nav: widget.nav),
      // Filing a claim is deliberately absent on mobile — see the note in
      // insurance_screen.dart. Apple rejected 1.0 under guideline 5.1.1(ix),
      // which restricts highly regulated services to organization accounts.
      // This screen only shows claims raised from the desktop application.
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
              return ListView(children: [Padding(padding: const EdgeInsets.all(24), child: Text(t.claimsEmpty, textAlign: TextAlign.center))]);
            }
            return ListView.separated(
              itemCount: items.length,
              separatorBuilder: (_, _) => const Divider(height: 1),
              itemBuilder: (context, i) {
                final m = items[i];
                final heading = (m['tracking_code'] ?? m['id'] ?? '—').toString();
                return ListTile(
                  title: Text(heading, style: const TextStyle(fontWeight: FontWeight.w600)),
                  subtitle: Text(_claimType(t, m['type'])),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(statusText(t, m['status'])),
                      const Padding(
                        padding: EdgeInsetsDirectional.only(start: 4),
                        child: Icon(Icons.chevron_right, size: 20, color: Brand.muted),
                      ),
                    ],
                  ),
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => ResourceDetailScreen(
                        title: t.detailClaim,
                        heading: heading,
                        fields: [
                          DetailField(t.fieldStatus, statusText(t, m['status'])),
                          DetailField(t.fieldType, _claimType(t, m['type'])),
                          DetailField(
                            t.fieldAmount,
                            formatMoney(m['requested_amount'] ?? m['amount'],
                                currency: (m['currency'] ?? 'USD').toString(),
                                locale: t.localeName),
                          ),
                          DetailField(t.fieldTrackingCode,
                              (m['tracking_code'] ?? '').toString()),
                          DetailField(t.fieldDescription,
                              (m['description'] ?? '').toString()),
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

/// The claim type in the reader's language.
///
/// EasyPost sends the enum — "damage" — and the list printed it raw, in
/// English, beside a status that does translate. Total by construction: an
/// unrecognised type is tidied rather than dropped, since hiding it would lose
/// the only thing distinguishing one claim from another.
String _claimType(AppLocalizations t, Object? raw) {
  final type = (raw ?? '').toString().trim();
  switch (type.toLowerCase()) {
    case 'damage':
      return t.claimTypeDamage;
    case 'theft':
      return t.claimTypeTheft;
    case 'loss':
      return t.claimTypeLoss;
    default:
      return type.replaceAll('_', ' ');
  }
}
