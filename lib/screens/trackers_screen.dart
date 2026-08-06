import 'package:flutter/material.dart';

import '../models/tracker.dart';
import '../services/pairing_store.dart';
import '../services/proxy_client.dart';
import 'home_shell.dart';
import 'tracker_detail_screen.dart';

enum SortBy { status, carrier, code, updated }

class TrackersScreen extends StatefulWidget {
  final PairingCredentials creds;
  final AppNav nav;
  const TrackersScreen({super.key, required this.creds, required this.nav});

  @override
  State<TrackersScreen> createState() => _TrackersScreenState();
}

class _TrackersScreenState extends State<TrackersScreen> {
  final ProxyClient _proxy = ProxyClient();
  late Future<List<Tracker>> _future;

  SortBy _sort = SortBy.status;
  final Set<String> _hiddenStatuses = {};
  final Set<String> _hiddenCarriers = {};

  @override
  void initState() {
    super.initState();
    _future = _load();
  }

  Future<List<Tracker>> _load() async {
    final raw = await _proxy.getTrackers(widget.creds);
    return raw.map(Tracker.fromJson).toList();
  }

  Future<void> _refresh() async {
    final f = _load();
    setState(() => _future = f);
    await f.catchError((_) => <Tracker>[]);
  }

  bool get _filtersActive => _hiddenStatuses.isNotEmpty || _hiddenCarriers.isNotEmpty;

  List<Tracker> _apply(List<Tracker> all) {
    final list = all
        .where((t) => !_hiddenStatuses.contains(t.status) && !_hiddenCarriers.contains(t.carrier))
        .toList();
    switch (_sort) {
      case SortBy.status:
        list.sort((a, b) => statusOrder(a.status).compareTo(statusOrder(b.status)));
        break;
      case SortBy.carrier:
        list.sort((a, b) => a.carrier.toLowerCase().compareTo(b.carrier.toLowerCase()));
        break;
      case SortBy.code:
        list.sort((a, b) => a.trackingCode.compareTo(b.trackingCode));
        break;
      case SortBy.updated:
        list.sort((a, b) => (b.updatedAt ?? DateTime(1970)).compareTo(a.updatedAt ?? DateTime(1970)));
        break;
    }
    return list;
  }

  void _openFilterSheet(List<Tracker> all) {
    final statuses = {for (final t in all) t.status}.toList()
      ..sort((a, b) => statusOrder(a).compareTo(statusOrder(b)));
    final carriers = {for (final t in all) t.carrier}.toList()..sort();
    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setSheet) => Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Hide delivered'),
                  value: _hiddenStatuses.contains('delivered'),
                  onChanged: (v) {
                    setState(() => v ? _hiddenStatuses.add('delivered') : _hiddenStatuses.remove('delivered'));
                    setSheet(() {});
                  },
                ),
                const SizedBox(height: 8),
                const Text('Status', style: TextStyle(fontWeight: FontWeight.w600)),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 4,
                  children: [
                    for (final s in statuses)
                      FilterChip(
                        label: Text(statusStyle(s).label),
                        avatar: Icon(statusStyle(s).icon, size: 18, color: statusStyle(s).color),
                        selected: !_hiddenStatuses.contains(s),
                        onSelected: (sel) {
                          setState(() => sel ? _hiddenStatuses.remove(s) : _hiddenStatuses.add(s));
                          setSheet(() {});
                        },
                      ),
                  ],
                ),
                if (carriers.length > 1) ...[
                  const SizedBox(height: 16),
                  const Text('Carrier', style: TextStyle(fontWeight: FontWeight.w600)),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 4,
                    children: [
                      for (final c in carriers)
                        FilterChip(
                          label: Text(c.isEmpty ? 'Unknown' : c),
                          avatar: CircleAvatar(radius: 8, backgroundColor: carrierColor(c)),
                          selected: !_hiddenCarriers.contains(c),
                          onSelected: (sel) {
                            setState(() => sel ? _hiddenCarriers.remove(c) : _hiddenCarriers.add(c));
                            setSheet(() {});
                          },
                        ),
                    ],
                  ),
                ],
                const SizedBox(height: 12),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      setState(() {
                        _hiddenStatuses.clear();
                        _hiddenCarriers.clear();
                      });
                      setSheet(() {});
                    },
                    child: const Text('Reset filters'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(nav: widget.nav),
      appBar: AppBar(
        title: const Text('Tracking'),
        actions: [
          PopupMenuButton<SortBy>(
            icon: const Icon(Icons.sort),
            tooltip: 'Sort',
            initialValue: _sort,
            onSelected: (s) => setState(() => _sort = s),
            itemBuilder: (_) => const [
              PopupMenuItem(value: SortBy.status, child: Text('Sort by status')),
              PopupMenuItem(value: SortBy.carrier, child: Text('Sort by carrier')),
              PopupMenuItem(value: SortBy.code, child: Text('Sort by tracking code')),
              PopupMenuItem(value: SortBy.updated, child: Text('Sort by recently updated')),
            ],
          ),
          FutureBuilder<List<Tracker>>(
            future: _future,
            builder: (_, snap) => IconButton(
              icon: Icon(_filtersActive ? Icons.filter_alt : Icons.filter_alt_outlined),
              tooltip: 'Filter',
              onPressed: snap.hasData ? () => _openFilterSheet(snap.data!) : null,
            ),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: FutureBuilder<List<Tracker>>(
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
            final all = snapshot.data ?? const [];
            final shown = _apply(all);
            if (all.isEmpty) {
              return ListView(children: const [
                Padding(
                  padding: EdgeInsets.all(24),
                  child: Text('No shipments are being tracked yet.', textAlign: TextAlign.center),
                ),
              ]);
            }
            return ListView(
              children: [
                if (_filtersActive || shown.length != all.length)
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                    child: Text('Showing ${shown.length} of ${all.length}',
                        style: Theme.of(context).textTheme.bodySmall),
                  ),
                for (final t in shown) _TrackerTile(tracker: t),
                if (shown.isEmpty)
                  const Padding(
                    padding: EdgeInsets.all(24),
                    child: Text('Nothing matches the current filters.', textAlign: TextAlign.center),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _TrackerTile extends StatelessWidget {
  final Tracker tracker;
  const _TrackerTile({required this.tracker});

  @override
  Widget build(BuildContext context) {
    final ss = statusStyle(tracker.status);
    final cc = carrierColor(tracker.carrier);
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: cc,
        child: Icon(ss.icon, color: Colors.white, size: 22),
      ),
      title: Text(tracker.trackingCode, style: const TextStyle(fontWeight: FontWeight.w600)),
      subtitle: Row(
        children: [
          Text(
            tracker.carrier.isEmpty ? 'Unknown carrier' : tracker.carrier,
            style: TextStyle(color: cc, fontWeight: FontWeight.w600),
          ),
          if (tracker.estDelivery != null) ...[
            const Text('  ·  '),
            Flexible(child: Text('ETA ${formatDate(tracker.estDelivery)}', overflow: TextOverflow.ellipsis)),
          ],
        ],
      ),
      trailing: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: ss.color.withValues(alpha: 0.12),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(ss.label, style: TextStyle(color: ss.color, fontSize: 12, fontWeight: FontWeight.w600)),
      ),
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => TrackerDetailScreen(tracker: tracker)),
      ),
    );
  }
}
