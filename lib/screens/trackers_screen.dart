import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';
import '../models/tracker.dart';
import '../services/error_text.dart';
import '../services/pairing_store.dart';
import '../services/proxy_client.dart';
import '../theme.dart';
import '../services/review_prompt.dart';
import 'home_shell.dart';
import 'tracker_detail_screen.dart';

enum SortBy { status, carrier, code, updated }

class TrackersScreen extends StatefulWidget {
  final PairingCredentials creds;
  final AppNav nav;

  /// Tracking is where a rating is earned: it is the screen the user opens the
  /// app for, and the only one whose success means "it showed me my parcels".
  final ReviewPrompt review;

  const TrackersScreen({
    super.key,
    required this.creds,
    required this.nav,
    required this.review,
  });

  @override
  State<TrackersScreen> createState() => _TrackersScreenState();
}

class _TrackersScreenState extends State<TrackersScreen> {
  final ProxyClient _proxy = ProxyClient();
  late Future<List<Tracker>> _future;

  /// The shipments behind these parcels, by id, from the list History reads.
  Map<String, Map<String, dynamic>> _shipments = const {};

  SortBy _sort = SortBy.status;
  final Set<String> _hiddenStatuses = {};
  final Set<String> _hiddenCarriers = {};

  @override
  void initState() {
    super.initState();
    _future = _load();
    _loadShipments();
  }

  /// Fetched beside the trackers, not before them, so the list is never held
  /// back for a second collection. A shipment record carries its rates, parcel
  /// and both addresses, and an account's worth of them arrives well after its
  /// trackers do; the addresses fill in when they land.
  ///
  /// A failure here costs the recipient, purchase date and refund state, and
  /// nothing more. The parcels are still true without them, so it neither
  /// replaces the list with an error nor counts as friction for the rating
  /// ask, which is gated on the parcels.
  Future<void> _loadShipments() async {
    final Map<String, Map<String, dynamic>> byId;
    try {
      byId = shipmentsById(await _proxy.getShipments(widget.creds));
    } catch (_) {
      // Whatever an earlier load found stays. A recipient and a purchase date
      // never change; a refund state can, so a refresh replaces the lot.
      return;
    }
    if (mounted) setState(() => _shipments = byId);
  }

  Future<List<Tracker>> _load() async {
    final List<Map<String, dynamic>> raw;
    try {
      raw = await _proxy.getTrackers(widget.creds);
    } catch (_) {
      // A failed load stands the ask down for this session, and is rethrown
      // untouched so the FutureBuilder still shows the error it always did.
      widget.review.noteFriction();
      rethrow;
    }
    // Arms; and asks only if it was armed on an earlier day, which is the
    // rule that keeps this off the list the user is reading right now. Asking
    // here as well as on resume is what reaches a user who launches the app
    // cold and never backgrounds it — `resumed` does not fire for them.
    await widget.review.recordSuccess();
    await widget.review.maybeAsk();
    return raw.map(Tracker.fromJson).toList();
  }

  Future<void> _refresh() async {
    final shipments = _loadShipments();
    final f = _load();
    setState(() => _future = f);
    await Future.wait([f.catchError((_) => <Tracker>[]), shipments]);
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
    final t = AppLocalizations.of(context);
    final statuses = {for (final tr in all) tr.status}.toList()
      ..sort((a, b) => statusOrder(a).compareTo(statusOrder(b)));
    final carriers = {for (final tr in all) tr.carrier}.toList()..sort();
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
                  title: Text(t.filterHideDelivered),
                  value: _hiddenStatuses.contains('delivered'),
                  onChanged: (v) {
                    setState(() => v ? _hiddenStatuses.add('delivered') : _hiddenStatuses.remove('delivered'));
                    setSheet(() {});
                  },
                ),
                const SizedBox(height: 8),
                Text(t.filterStatusHeading, style: const TextStyle(fontWeight: FontWeight.w600)),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 4,
                  children: [
                    for (final s in statuses)
                      FilterChip(
                        label: Text(statusLabel(t, s)),
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
                  Text(t.filterCarrierHeading, style: const TextStyle(fontWeight: FontWeight.w600)),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 4,
                    children: [
                      for (final c in carriers)
                        FilterChip(
                          label: Text(c.isEmpty ? t.carrierUnknownShort : carrierDisplayName(c)),
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
                    child: Text(t.filterReset),
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
    final t = AppLocalizations.of(context);
    return Scaffold(
      drawer: NavDrawer(nav: widget.nav),
      appBar: AppBar(
        title: Text(t.navTracking),
        actions: [
          PopupMenuButton<SortBy>(
            icon: const Icon(Icons.sort),
            tooltip: t.sortTooltip,
            initialValue: _sort,
            onSelected: (s) => setState(() => _sort = s),
            itemBuilder: (_) => [
              PopupMenuItem(value: SortBy.status, child: Text(t.sortByStatus)),
              PopupMenuItem(value: SortBy.carrier, child: Text(t.sortByCarrier)),
              PopupMenuItem(value: SortBy.code, child: Text(t.sortByCode)),
              PopupMenuItem(value: SortBy.updated, child: Text(t.sortByUpdated)),
            ],
          ),
          FutureBuilder<List<Tracker>>(
            future: _future,
            builder: (_, snap) => IconButton(
              icon: Icon(_filtersActive ? Icons.filter_alt : Icons.filter_alt_outlined),
              tooltip: t.filterTooltip,
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
                  child: Text(describeError(t, snapshot.error), textAlign: TextAlign.center),
                ),
              ]);
            }
            final all = snapshot.data ?? const [];
            final shown = _apply(all);
            if (all.isEmpty) {
              return ListView(children: [
                Padding(
                  padding: const EdgeInsets.all(24),
                  child: Text(t.trackersEmpty, textAlign: TextAlign.center),
                ),
              ]);
            }
            return ListView(
              children: [
                if (_filtersActive || shown.length != all.length)
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                    child: Text(t.trackersShowing(shown.length, all.length),
                        style: Theme.of(context).textTheme.bodySmall),
                  ),
                for (final tracker in shown)
                  _TrackerTile(
                    tracker: tracker,
                    shipment: shipmentFor(tracker, _shipments),
                  ),
                if (shown.isEmpty)
                  Padding(
                    padding: const EdgeInsets.all(24),
                    child: Text(t.trackersNoMatch, textAlign: TextAlign.center),
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

  /// The shipment this parcel's label was bought on; null when the tracker was
  /// added by tracking number, or before the shipments have loaded.
  final Map<String, dynamic>? shipment;

  const _TrackerTile({required this.tracker, this.shipment});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    final ss = statusStyle(tracker.status);
    final cc = carrierColor(tracker.carrier);
    final place = formatPlace(shipment?['to_address']);
    final created = formatDateShort(
        DateTime.tryParse((shipment?['created_at'] ?? '').toString()), t.localeName);
    final refund = shipment == null ? '' : refundStateOf(shipment!);
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: cc,
        child: Icon(ss.icon, color: Colors.white, size: 22),
      ),
      title: Text(tracker.trackingCode, style: const TextStyle(fontWeight: FontWeight.w600)),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Text(
                tracker.carrier.isEmpty ? t.carrierUnknown : carrierDisplayName(tracker.carrier),
                style: TextStyle(color: cc, fontWeight: FontWeight.w600),
              ),
              if (tracker.estDelivery != null) ...[
                const Text(' · '),
                Flexible(
                  child: Text(
                    t.etaLabel(formatDateShort(tracker.estDelivery, t.localeName)),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ],
          ),
          // A line of its own rather than a third item on the carrier's. That
          // line is already sized to the last point for a long carrier beside a
          // long ETA (see the badge note below), so a town appended to it would
          // be the first thing ellipsised away.
          if (place.isNotEmpty)
            Text(place, maxLines: 1, overflow: TextOverflow.ellipsis),
          // When the label was bought, which is the only date on this row that
          // has already happened: the line above it is an estimate. Smaller and
          // muted so the row still reads status-first at a glance.
          if (created.isNotEmpty)
            Text(t.createdLabel(created),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 12, color: Brand.muted)),
        ],
      ),
      // Capped, and allowed to wrap inside the cap. A long status name —
      // "Disponible en point relais", "Rücksendung an Absender" — is as wide as
      // the row, and an unbounded badge took that width from the subtitle,
      // which then ellipsised to "Prévu 14 …". Two lines of badge cost nothing:
      // the row is already tall enough for them.
      //
      // 110, not the 132 tried first: at 132 the longest subtitle in the shot
      // list — "Parcelforce · Prévu 14 août", a long carrier beside a long
      // status — was still a few points short.
      // 11pt inside 6 of padding, not 12 inside 8. A cap only helps if the
      // longest single word still fits inside it: at 12pt "Fehlgeschlagen"
      // did not, and German published a badge reading "Fehlgeschlage" over
      // "n". Wrapping between words is fine; wrapping inside one is not, and
      // a word cannot be wrapped any other way.
      trailing: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 110),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            _badge(statusLabel(t, tracker.status), ss.color),
            // A second badge rather than a longer first one. A parcel's status
            // and its refund's are different vocabularies — a parcel is never
            // "refunded" — and one badge reading both invites the reading that
            // they are one event. Its own colour, from refundStatusStyle, for
            // the same reason.
            if (refund.isNotEmpty) ...[
              const SizedBox(height: 4),
              _badge(refundStatusLabel(t, refund), refundStatusStyle(refund).color),
            ],
          ],
        ),
      ),
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => TrackerDetailScreen(tracker: tracker, shipment: shipment),
        ),
      ),
    );
  }

  /// 11pt inside 6 of padding, for the reason in the note above: at 12pt the
  /// longest single German word did not fit the cap and was wrapped mid-word.
  static Widget _badge(String text, Color color) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.12),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(color: color, fontSize: 11, fontWeight: FontWeight.w600),
        ),
      );
}
