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
  final ProxyClient proxy;
  const PickupsScreen(
      {super.key, required this.nav, required this.creds, required this.proxy});

  @override
  State<PickupsScreen> createState() => _PickupsScreenState();
}

class _PickupsScreenState extends State<PickupsScreen> {
  ProxyClient get _proxy => widget.proxy;
  late Future<List<Map<String, dynamic>>> _future;

  /// Every cancel still waiting on the proxy. A set rather than one id: with a
  /// single id, the first cancel to finish cleared the spinner on the second,
  /// whose button came back and could send the same POST again.
  final Set<String> _busyIds = {};

  @override
  void initState() {
    super.initState();
    _future = _proxy.getPickups(widget.creds);
  }

  Future<void> _refresh() async {
    final f = _proxy.getPickups(widget.creds);
    setState(() {
      _future = f;
    });
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
    if (ok != true || !mounted || _busyIds.contains(id)) return;
    final messenger = ScaffoldMessenger.of(context);
    setState(() => _busyIds.add(id));
    try {
      await _proxy.cancelPickup(widget.creds, id);
      messenger.showSnackBar(SnackBar(content: Text(t.pickupCancelDone)));
    } catch (e) {
      messenger.showSnackBar(SnackBar(content: Text(describeError(t, e))));
    } finally {
      if (mounted) setState(() => _busyIds.remove(id));
    }
    // Refreshed on failure as well. A cancel whose response was lost may still
    // have succeeded at EasyPost, and the list is the only place that can say.
    if (mounted) await _refresh();
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
                final cancellable = pickupCancellable(m);
                return ListTile(
                  title: Text(id, style: const TextStyle(fontWeight: FontWeight.w600)),
                  subtitle: Text([m['reference'], pickupStatusText(t, status)]
                      .where((s) => s != null && '$s'.isNotEmpty)
                      .join('  ·  ')),
                  trailing: _busyIds.contains(id)
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
                          DetailField(t.fieldStatus, pickupStatusText(t, status)),
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

/// Whether a pickup offers Cancel: only when EasyPost says it is `scheduled`.
///
/// This used to offer Cancel on everything not cancelled, which included a
/// status of `unknown`. The collection window is deliberately not consulted:
/// the demo fixtures that feed the store screenshots carry fixed dates that are
/// already past, and EasyPost refuses a cancel it cannot honour with its own
/// message, which the snackbar shows.
bool pickupCancellable(Map<String, dynamic> pickup) =>
    (pickup['status'] ?? '').toString().trim() == 'scheduled';

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
