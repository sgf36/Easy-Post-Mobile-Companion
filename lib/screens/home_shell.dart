import 'package:flutter/material.dart';

import '../services/pairing_store.dart';
import '../services/proxy_client.dart';
import '../theme.dart';
import 'hts_screen.dart';
import 'reports_screen.dart';
import 'resource_list_screen.dart';
import 'trackers_screen.dart';

/// The app's sections, mirroring Easy-Post Desktop's sidebar.
enum Section { tracking, history, insurance, claims, pickups, reports, hts }

extension SectionMeta on Section {
  String get label => switch (this) {
        Section.tracking => 'Tracking',
        Section.history => 'History',
        Section.insurance => 'Insurance',
        Section.claims => 'Claims',
        Section.pickups => 'Pickups',
        Section.reports => 'Reports',
        Section.hts => 'HTS Lookup',
      };

  IconData get icon => switch (this) {
        Section.tracking => Icons.local_shipping,
        Section.history => Icons.history,
        Section.insurance => Icons.verified_user,
        Section.claims => Icons.gavel,
        Section.pickups => Icons.event_available,
        Section.reports => Icons.bar_chart,
        Section.hts => Icons.travel_explore,
      };
}

/// Passed to each section so it can render the shared drawer and switch sections.
class AppNav {
  final Section current;
  final void Function(Section) onSelect;
  final Future<void> Function() onUnpair;
  const AppNav({required this.current, required this.onSelect, required this.onUnpair});
}

class HomeShell extends StatefulWidget {
  final PairingCredentials creds;
  final Future<void> Function() onUnpair;
  const HomeShell({super.key, required this.creds, required this.onUnpair});

  @override
  State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> {
  Section _section = Section.tracking;

  @override
  Widget build(BuildContext context) {
    final nav = AppNav(
      current: _section,
      onSelect: (s) => setState(() => _section = s),
      onUnpair: widget.onUnpair,
    );
    final c = widget.creds;
    final proxy = ProxyClient();
    return switch (_section) {
      Section.tracking => TrackersScreen(creds: c, nav: nav),
      Section.history => ResourceListScreen(
          nav: nav,
          title: 'History',
          emptyText: 'No shipments yet.',
          fetch: () => proxy.getShipments(c),
          row: (m) => ResourceRow(
            title: (m['tracking_code'] ?? m['id'] ?? '—').toString(),
            subtitle: _addr(m['to_address']),
            trailing: (m['status'] ?? '').toString(),
          ),
        ),
      Section.insurance => ResourceListScreen(
          nav: nav,
          title: 'Insurance',
          emptyText: 'No insurance policies yet.',
          fetch: () => proxy.getInsurances(c),
          row: (m) => ResourceRow(
            title: (m['tracking_code'] ?? m['id'] ?? '—').toString(),
            subtitle: (m['provider'] ?? m['carrier'] ?? '').toString(),
            trailing: _money(m['amount']),
          ),
        ),
      Section.claims => ResourceListScreen(
          nav: nav,
          title: 'Claims',
          emptyText: 'No claims filed yet.',
          fetch: () => proxy.getClaims(c),
          row: (m) => ResourceRow(
            title: (m['tracking_code'] ?? m['id'] ?? '—').toString(),
            subtitle: (m['type'] ?? '').toString(),
            trailing: (m['status'] ?? '').toString(),
          ),
        ),
      Section.pickups => ResourceListScreen(
          nav: nav,
          title: 'Pickups',
          emptyText: 'No pickups scheduled yet.',
          fetch: () => proxy.getPickups(c),
          row: (m) => ResourceRow(
            title: (m['id'] ?? '—').toString(),
            subtitle: (m['reference'] ?? '').toString(),
            trailing: (m['status'] ?? '').toString(),
          ),
        ),
      Section.reports => ReportsScreen(nav: nav, creds: c),
      Section.hts => HtsScreen(nav: nav),
    };
  }

  static String _addr(dynamic a) {
    if (a is Map) {
      final parts = [a['city'], a['state'], a['country']].where((p) => p != null && '$p'.trim().isNotEmpty);
      return parts.join(', ');
    }
    return '';
  }

  static String _money(dynamic v) {
    if (v == null) return '';
    return '\$$v';
  }
}

/// The shared navigation drawer.
class NavDrawer extends StatelessWidget {
  final AppNav nav;
  const NavDrawer({super.key, required this.nav});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Image.asset('assets/icon/app_icon.png', height: 36, width: 36),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Text('Easy-Post Mobile',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  ),
                ],
              ),
            ),
            const Divider(height: 1),
            Expanded(
              child: ListView(
                children: [
                  _header('Track & manage'),
                  for (final s in [Section.tracking, Section.history, Section.insurance, Section.claims, Section.pickups])
                    _tile(context, s),
                  _header('Tools'),
                  for (final s in [Section.reports, Section.hts]) _tile(context, s),
                ],
              ),
            ),
            const Divider(height: 1),
            ListTile(
              leading: const Icon(Icons.link_off),
              title: const Text('Unpair this device'),
              onTap: () {
                Navigator.of(context).pop();
                nav.onUnpair();
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _header(String text) => Padding(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
        child: Text(text.toUpperCase(),
            style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: Brand.muted, letterSpacing: 0.5)),
      );

  Widget _tile(BuildContext context, Section s) {
    final selected = s == nav.current;
    return ListTile(
      leading: Icon(s.icon, color: selected ? Brand.accent : null),
      title: Text(s.label,
          style: TextStyle(color: selected ? Brand.accent : null, fontWeight: selected ? FontWeight.w600 : null)),
      selected: selected,
      selectedTileColor: Brand.accentSoft,
      onTap: () {
        Navigator.of(context).pop();
        if (!selected) nav.onSelect(s);
      },
    );
  }
}
