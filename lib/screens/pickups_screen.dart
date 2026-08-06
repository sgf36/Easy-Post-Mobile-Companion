import 'package:flutter/material.dart';

import '../services/pairing_store.dart';
import '../services/proxy_client.dart';
import 'home_shell.dart';

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
    final id = (pickup['id'] ?? '').toString();
    if (id.isEmpty) return;
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Cancel pickup?'),
        content: Text('Cancel pickup $id? This cannot be undone.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Keep')),
          FilledButton(onPressed: () => Navigator.pop(ctx, true), child: const Text('Cancel pickup')),
        ],
      ),
    );
    if (ok != true) return;
    setState(() => _busyId = id);
    try {
      await _proxy.cancelPickup(widget.creds, id);
      await _refresh();
    } catch (e) {
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
    } finally {
      if (mounted) setState(() => _busyId = null);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pickups')),
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
              return ListView(children: [Padding(padding: const EdgeInsets.all(24), child: Text('${snap.error}', textAlign: TextAlign.center))]);
            }
            final items = snap.data ?? const [];
            if (items.isEmpty) {
              return ListView(children: const [Padding(padding: EdgeInsets.all(24), child: Text('No pickups scheduled yet.', textAlign: TextAlign.center))]);
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
                  subtitle: Text([m['reference'], status].where((s) => s != null && '$s'.isNotEmpty).join('  ·  ')),
                  trailing: _busyId == id
                      ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2))
                      : (cancellable
                          ? TextButton(onPressed: () => _cancel(m), child: const Text('Cancel'))
                          : null),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
