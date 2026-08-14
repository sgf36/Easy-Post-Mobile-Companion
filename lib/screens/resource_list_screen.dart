import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';
import '../services/error_text.dart';
import '../theme.dart';
import 'home_shell.dart';

/// One row's display fields, derived from a raw EasyPost object.
class ResourceRow {
  final String title;
  final String subtitle;
  final String trailing;
  const ResourceRow({required this.title, this.subtitle = '', this.trailing = ''});
}

/// A generic list section: fetch a collection through the proxy and render it,
/// with pull-to-refresh, loading, empty and error states. Used by History,
/// Insurance, Claims and Pickups.
class ResourceListScreen extends StatefulWidget {
  final AppNav nav;
  final String title;
  final String emptyText;
  final Future<List<Map<String, dynamic>>> Function() fetch;
  final ResourceRow Function(Map<String, dynamic>) row;

  /// Builds the page a row opens onto. Supplied by the caller because only it
  /// knows what the raw record means; a null builder leaves rows inert, which
  /// is what every list here used to be.
  final Widget Function(Map<String, dynamic>)? detail;

  const ResourceListScreen({
    super.key,
    required this.nav,
    required this.title,
    required this.emptyText,
    required this.fetch,
    required this.row,
    this.detail,
  });

  @override
  State<ResourceListScreen> createState() => _ResourceListScreenState();
}

/// The trailing text, followed by a chevron when the row opens onto something.
///
/// Without the chevron a tappable row and an inert one look identical, and the
/// only way to find out which this is would be to tap it.
Widget? _trailing(ResourceRow r, {required bool showChevron}) {
  if (r.trailing.isEmpty && !showChevron) return null;
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      if (r.trailing.isNotEmpty) Text(r.trailing),
      if (showChevron)
        const Padding(
          padding: EdgeInsetsDirectional.only(start: 4),
          child: Icon(Icons.chevron_right, size: 20, color: Brand.muted),
        ),
    ],
  );
}

class _ResourceListScreenState extends State<ResourceListScreen> {
  late Future<List<Map<String, dynamic>>> _future;

  @override
  void initState() {
    super.initState();
    _future = widget.fetch();
  }

  Future<void> _refresh() async {
    final f = widget.fetch();
    setState(() => _future = f);
    await f.catchError((_) => <Map<String, dynamic>>[]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
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
              return ListView(children: [
                Padding(
                    padding: const EdgeInsets.all(24),
                    child: Text(describeError(AppLocalizations.of(context), snap.error),
                        textAlign: TextAlign.center)),
              ]);
            }
            final items = snap.data ?? const [];
            if (items.isEmpty) {
              return ListView(children: [
                Padding(padding: const EdgeInsets.all(24), child: Text(widget.emptyText, textAlign: TextAlign.center)),
              ]);
            }
            return ListView.separated(
              itemCount: items.length,
              separatorBuilder: (_, _) => const Divider(height: 1),
              itemBuilder: (context, i) {
                final r = widget.row(items[i]);
                final build = widget.detail;
                return ListTile(
                  title: Text(r.title, style: const TextStyle(fontWeight: FontWeight.w600)),
                  subtitle: r.subtitle.isEmpty ? null : Text(r.subtitle),
                  trailing: _trailing(r, showChevron: build != null),
                  onTap: build == null
                      ? null
                      : () => Navigator.of(context).push(
                            MaterialPageRoute(builder: (_) => build(items[i])),
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
