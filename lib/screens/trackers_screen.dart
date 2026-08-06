import 'package:flutter/material.dart';

import '../services/pairing_store.dart';
import '../services/proxy_client.dart';

/// The Phase 0 payoff: a live list of the paired account's trackers, fetched
/// through the proxy. Pull to refresh; unpair from the app bar.
class TrackersScreen extends StatefulWidget {
  final PairingCredentials creds;
  final Future<void> Function() onUnpair;
  const TrackersScreen({super.key, required this.creds, required this.onUnpair});

  @override
  State<TrackersScreen> createState() => _TrackersScreenState();
}

class _TrackersScreenState extends State<TrackersScreen> {
  final ProxyClient _proxy = ProxyClient();
  late Future<List<Map<String, dynamic>>> _future;

  @override
  void initState() {
    super.initState();
    _future = _proxy.getTrackers(widget.creds);
  }

  Future<void> _refresh() async {
    final future = _proxy.getTrackers(widget.creds);
    setState(() => _future = future);
    await future.catchError((_) => <Map<String, dynamic>>[]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tracking'),
        actions: [
          IconButton(
            onPressed: () => widget.onUnpair(),
            icon: const Icon(Icons.link_off),
            tooltip: 'Unpair this device',
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: FutureBuilder<List<Map<String, dynamic>>>(
          future: _future,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return ListView(children: [
                Padding(
                  padding: const EdgeInsets.all(24),
                  child: Text('${snapshot.error}', textAlign: TextAlign.center),
                ),
              ]);
            }
            final trackers = snapshot.data ?? const [];
            if (trackers.isEmpty) {
              return ListView(children: const [
                Padding(
                  padding: EdgeInsets.all(24),
                  child: Text('No shipments are being tracked yet.',
                      textAlign: TextAlign.center),
                ),
              ]);
            }
            return ListView.separated(
              itemCount: trackers.length,
              separatorBuilder: (_, _) => const Divider(height: 1),
              itemBuilder: (context, i) {
                final t = trackers[i];
                final code = t['tracking_code']?.toString() ?? '—';
                final status = t['status']?.toString() ?? 'unknown';
                final carrier = t['carrier']?.toString() ?? '';
                return ListTile(
                  title: Text(code),
                  subtitle: Text(carrier),
                  trailing: Text(status),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
