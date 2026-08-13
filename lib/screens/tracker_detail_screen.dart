import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import '../l10n/app_localizations.dart';
import '../models/tracker.dart';
import '../services/geocode.dart';

class TrackerDetailScreen extends StatelessWidget {
  final Tracker tracker;
  const TrackerDetailScreen({super.key, required this.tracker});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    final ss = statusStyle(tracker.status);
    final cc = carrierColor(tracker.carrier);
    final events = tracker.events.reversed.toList(); // newest first

    return Scaffold(
      appBar: AppBar(title: Text(tracker.trackingCode)),
      body: ListView(
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(backgroundColor: cc, child: Icon(ss.icon, color: Colors.white)),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(tracker.carrier.isEmpty ? t.carrierUnknown : carrierDisplayName(tracker.carrier),
                              style: TextStyle(color: cc, fontWeight: FontWeight.bold, fontSize: 16)),
                          Text(statusLabel(t, tracker.status),
                              style: TextStyle(color: ss.color, fontWeight: FontWeight.w600)),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                if (statusDetailText(tracker.status, tracker.statusDetail) != null)
                  _infoRow(Icons.info_outline,
                      statusDetailText(tracker.status, tracker.statusDetail)!),
                if (tracker.estDelivery != null)
                  _infoRow(
                      Icons.event,
                      t.detailEstimatedDelivery(
                          formatDate(tracker.estDelivery, t.localeName))),
                if (tracker.signedBy != null && tracker.signedBy!.isNotEmpty)
                  _infoRow(Icons.draw, t.detailSignedBy(tracker.signedBy!)),
              ],
            ),
          ),

          // Journey map (best-effort; city-level pins)
          if (events.any((e) => e.locationLabel != null)) _JourneyMap(tracker: tracker),

          const Divider(height: 1),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Text(t.detailHistoryHeading, style: Theme.of(context).textTheme.titleMedium),
          ),
          if (events.isEmpty)
            Padding(
              padding: const EdgeInsets.all(24),
              child: Text(t.detailNoScanHistory, textAlign: TextAlign.center),
            ),
          for (var i = 0; i < events.length; i++)
            _TimelineRow(event: events[i], isFirst: i == 0, isLast: i == events.length - 1),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _infoRow(IconData icon, String text) => Padding(
        padding: const EdgeInsets.only(top: 4),
        child: Row(
          children: [
            Icon(icon, size: 16, color: Colors.grey),
            const SizedBox(width: 8),
            Expanded(child: Text(text)),
          ],
        ),
      );
}

class _TimelineRow extends StatelessWidget {
  final TrackEvent event;
  final bool isFirst;
  final bool isLast;
  const _TimelineRow({required this.event, required this.isFirst, required this.isLast});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    final ss = statusStyle(event.status);
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Timeline gutter: connector line + status dot.
          SizedBox(
            width: 56,
            child: Column(
              children: [
                Container(width: 2, height: 10, color: isFirst ? Colors.transparent : Colors.grey.shade300),
                Icon(ss.icon, color: ss.color, size: 22),
                Expanded(child: Container(width: 2, color: isLast ? Colors.transparent : Colors.grey.shade300)),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 16, top: 6, bottom: 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(event.message.isEmpty ? statusLabel(t, event.status) : event.message,
                      style: const TextStyle(fontWeight: FontWeight.w600)),
                  const SizedBox(height: 2),
                  Text(
                    [event.locationLabel, formatDateTime(event.datetime, t.localeName)]
                        .where((s) => s != null && s.isNotEmpty)
                        .join('  ·  '),
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// City-level journey map. Geocodes each scan location via OSM (cached),
/// dropping a pin per located stop and joining them in order. Degrades to a
/// note if nothing can be located.
class _JourneyMap extends StatefulWidget {
  final Tracker tracker;
  const _JourneyMap({required this.tracker});

  @override
  State<_JourneyMap> createState() => _JourneyMapState();
}

class _JourneyMapState extends State<_JourneyMap> {
  bool _loading = true;
  final List<LatLng> _points = [];

  @override
  void initState() {
    super.initState();
    _geocode();
  }

  Future<void> _geocode() async {
    // Unique locations in chronological order.
    final seen = <String>{};
    final located = <LatLng>[];
    for (final e in widget.tracker.events) {
      final label = e.locationLabel;
      if (label == null || !seen.add(label)) continue;
      final ll = await Geocoder.lookup(city: e.city, state: e.state, country: e.country);
      if (ll != null) located.add(ll);
    }
    if (!mounted) return;
    setState(() {
      _points
        ..clear()
        ..addAll(located);
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const SizedBox(height: 220, child: Center(child: CircularProgressIndicator()));
    }
    if (_points.isEmpty) {
      return SizedBox(
        height: 60,
        child: Center(
          child: Text(AppLocalizations.of(context).detailMapUnavailable,
              style: const TextStyle(color: Colors.grey)),
        ),
      );
    }
    return SizedBox(
      height: 220,
      child: FlutterMap(
        options: MapOptions(
          initialCameraFit: CameraFit.coordinates(
            coordinates: _points,
            padding: const EdgeInsets.all(40),
            maxZoom: 12,
          ),
          interactionOptions: const InteractionOptions(flags: InteractiveFlag.all & ~InteractiveFlag.rotate),
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'com.spencerfields.easypostmobilecompanion',
          ),
          if (_points.length > 1)
            PolylineLayer(
              polylines: [
                Polyline(points: _points, color: const Color(0xFF2B6CB0), strokeWidth: 3),
              ],
            ),
          MarkerLayer(
            markers: [
              for (var i = 0; i < _points.length; i++)
                Marker(
                  point: _points[i],
                  width: 22,
                  height: 22,
                  child: Container(
                    decoration: BoxDecoration(
                      color: i == 0
                          ? const Color(0xFF2E7D32) // origin
                          : (i == _points.length - 1 ? const Color(0xFFC62828) : const Color(0xFF2B6CB0)),
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
