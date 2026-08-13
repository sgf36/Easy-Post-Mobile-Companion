import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';
import '../services/pairing_store.dart';
import '../services/proxy_client.dart';
import '../theme.dart';
import 'claims_screen.dart';
import 'hts_screen.dart';
import 'insurance_screen.dart';
import 'pickups_screen.dart';
import 'reports_screen.dart';
import 'resource_list_screen.dart';
import 'trackers_screen.dart';

/// The app's sections, mirroring Easy-Post Desktop's sidebar.
enum Section { tracking, history, insurance, claims, pickups, reports, hts }

extension SectionMeta on Section {
  String label(AppLocalizations t) => switch (this) {
        Section.tracking => t.navTracking,
        Section.history => t.navHistory,
        Section.insurance => t.navInsurance,
        Section.claims => t.navClaims,
        Section.pickups => t.navPickups,
        Section.reports => t.navReports,
        Section.hts => t.navHts,
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
    final t = AppLocalizations.of(context);
    return switch (_section) {
      Section.tracking => TrackersScreen(creds: c, nav: nav),
      Section.history => ResourceListScreen(
          nav: nav,
          title: t.navHistory,
          emptyText: t.historyEmpty,
          fetch: () => proxy.getShipments(c),
          row: (m) => ResourceRow(
            title: (m['tracking_code'] ?? m['id'] ?? '—').toString(),
            subtitle: _addr(m['to_address']),
            trailing: (m['status'] ?? '').toString(),
          ),
        ),
      Section.insurance => InsuranceScreen(nav: nav, creds: c),
      Section.claims => ClaimsScreen(nav: nav, creds: c),
      Section.pickups => PickupsScreen(nav: nav, creds: c),
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
}

/// The shared navigation drawer.
class NavDrawer extends StatelessWidget {
  final AppNav nav;
  const NavDrawer({super.key, required this.nav});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
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
                  // The product name, shortened to fit the drawer header. A
                  // brand, so it is not translated — same rule as the carrier
                  // names.
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
                  _header(t.navSectionManage),
                  for (final s in [Section.tracking, Section.history, Section.insurance, Section.claims, Section.pickups])
                    _tile(context, s),
                  _header(t.navSectionTools),
                  for (final s in [Section.reports, Section.hts]) _tile(context, s),
                ],
              ),
            ),
            const Divider(height: 1),
            ListTile(
              leading: const Icon(Icons.link_off),
              title: Text(t.drawerUnpair),
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
      title: Text(s.label(AppLocalizations.of(context)),
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
