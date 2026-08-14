import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';
import '../models/tracker.dart';
import '../services/error_text.dart';
import '../services/pairing_store.dart';
import '../services/proxy_client.dart';
import '../theme.dart';
import 'home_shell.dart';
import 'resource_detail_screen.dart';

class PickupsScreen extends StatefulWidget {
  final AppNav nav;
  final PairingCredentials creds;
  const PickupsScreen({super.key, required this.nav, required this.creds});

  @override
  State<PickupsScreen> createState() => _PickupsScreenState();
}

class _PickupsScreenState extends State<PickupsScreen> {
  final _proxy = ProxyClient();
  late Future<List<Map<String, dynamic>>> _future;
  String? _busyId;

  @override
  void initState() {
    super.initState();
    _future = _proxy.getPickups(widget.creds);
  }

  Future<void> _refresh() async {
    final f = _proxy.getPickups(widget.creds);
    setState(() => _future = f);
    await f.catchError((_) => <Map<String, dynamic>>[]);
  }

  Future<void> _cancel(Map<String, dynamic> pickup) async {
    final t = AppLocalizations.of(context);
    final id = (pickup['id'] ?? '').toString();
    if (id.isEmpty) return;
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(t.pickupCancelTitle),
        content: Text(t.pickupCancelBody(id)),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: Text(t.pickupKeep)),
          FilledButton(
              onPressed: () => Navigator.pop(ctx, true), child: Text(t.pickupCancelConfirm)),
        ],
      ),
    );
    if (ok != true) return;
    setState(() => _busyId = id);
    try {
      await _proxy.cancelPickup(widget.creds, id);
      await _refresh();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(describeError(t, e))));
      }
    } finally {
      if (mounted) setState(() => _busyId = null);
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(t.navPickups)),
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
              return ListView(children: [Padding(padding: const EdgeInsets.all(24), child: Text(describeError(t, snap.error), textAlign: TextAlign.center))]);
            }
            final items = snap.data ?? const [];
            if (items.isEmpty) {
              return ListView(children: [Padding(padding: const EdgeInsets.all(24), child: Text(t.pickupsEmpty, textAlign: TextAlign.center))]);
            }
            return ListView.separated(
              itemCount: items.length,
              separatorBuilder: (_, _) => const Divider(height: 1),
              itemBuilder: (context, i) {
                final m = items[i];
                final id = (m['id'] ?? '—').toString();
                final status = (m['status'] ?? '').toString();
                final cancellable = status != 'cancelled' && status != 'canceled';
                return ListTile(
                  title: Text(id, style: const TextStyle(fontWeight: FontWeight.w600)),
                  subtitle: Text([m['reference'], statusText(t, status)]
                      .where((s) => s != null && '$s'.isNotEmpty)
                      .join('  ·  ')),
                  trailing: _busyId == id
                      ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2))
                      : (cancellable
                          ? TextButton(onPressed: () => _cancel(m), child: Text(t.actionCancel))
                          : const Icon(Icons.chevron_right, size: 20, color: Brand.muted)),
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => ResourceDetailScreen(
                        title: t.detailPickup,
                        heading: id,
                        fields: [
                          DetailField(t.fieldStatus, statusText(t, status)),
                          DetailField(t.fieldReference, (m['reference'] ?? '').toString()),
                          DetailField(t.fieldPickupWindow, _window(t, m)),
                          // A pickup's address is where the carrier collects
                          // from, which is what "From address" already says.
                          DetailField(
                              t.insuranceFromAddress, formatAddress(m['address'])),
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

/// The collection window as one phrase: "15 Aug 2026, 09:00 – 15 Aug 2026, 17:00".
///
/// An en dash rather than a hyphen, and both ends formatted for the reader's
/// locale. Degrades to whichever end exists instead of printing a dangling
/// separator, because EasyPost fills only `min_datetime` on some carriers.
String _window(AppLocalizations t, Map<String, dynamic> m) {
  final from = formatDateTime(
      DateTime.tryParse((m['min_datetime'] ?? '').toString()), t.localeName);
  final to = formatDateTime(
      DateTime.tryParse((m['max_datetime'] ?? '').toString()), t.localeName);
  if (from.isEmpty) return to;
  if (to.isEmpty) return from;
  return '$from – $to';
}
