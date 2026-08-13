import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../l10n/app_localizations.dart';
import '../services/error_text.dart';
import '../services/hts_service.dart';
import 'home_shell.dart';

/// HTS (Harmonized Tariff Schedule) code lookup — a Tools section. Standalone:
/// it queries the public USITC service directly, so it needs no pairing.
class HtsScreen extends StatefulWidget {
  final AppNav nav;
  const HtsScreen({super.key, required this.nav});

  @override
  State<HtsScreen> createState() => _HtsScreenState();
}

class _HtsScreenState extends State<HtsScreen> {
  final _controller = TextEditingController();
  Future<List<HtsResult>>? _future;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _search() {
    final kw = _controller.text.trim();
    if (kw.isEmpty) return;
    FocusScope.of(context).unfocus();
    // Assign inside a block: an arrow body would return the Future, which
    // setState asserts against.
    setState(() {
      _future = searchHts(kw);
    });
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(t.navHts)),
      drawer: NavDrawer(nav: widget.nav),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    textInputAction: TextInputAction.search,
                    onSubmitted: (_) => _search(),
                    decoration: InputDecoration(
                      labelText: t.htsSearchLabel,
                      hintText: t.htsSearchHint,
                      border: const OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                FilledButton(onPressed: _search, child: Text(t.htsSearchButton)),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
            child: Text(
              t.htsDisclaimer,
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ),
          Expanded(
            child: _future == null
                ? Center(child: Text(t.htsPrompt))
                : FutureBuilder<List<HtsResult>>(
                    future: _future,
                    builder: (context, snap) {
                      if (snap.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (snap.hasError) {
                        return Padding(
                          padding: const EdgeInsets.all(24),
                          child: Text(describeError(t, snap.error), textAlign: TextAlign.center),
                        );
                      }
                      final rows = snap.data ?? const [];
                      if (rows.isEmpty) {
                        return Padding(
                          padding: const EdgeInsets.all(24),
                          child: Text(t.htsNoResults, textAlign: TextAlign.center),
                        );
                      }
                      return ListView.separated(
                        itemCount: rows.length,
                        separatorBuilder: (_, _) => const Divider(height: 1),
                        itemBuilder: (context, i) {
                          final r = rows[i];
                          final rates = [
                            if (r.general.isNotEmpty) t.htsRateGeneral(r.general),
                            if (r.special.isNotEmpty) t.htsRateSpecial(r.special),
                            if (r.other.isNotEmpty) t.htsRateOther(r.other),
                          ].join('  ·  ');
                          return ListTile(
                            title: Text(r.htsno.isEmpty ? r.description : r.htsno,
                                style: const TextStyle(fontWeight: FontWeight.w600)),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (r.htsno.isNotEmpty && r.description.isNotEmpty) Text(r.description),
                                if (rates.isNotEmpty)
                                  Padding(
                                    padding: const EdgeInsets.only(top: 2),
                                    child: Text(rates, style: const TextStyle(fontSize: 12, color: Colors.grey)),
                                  ),
                              ],
                            ),
                            trailing: r.htsno.isEmpty
                                ? null
                                : IconButton(
                                    icon: const Icon(Icons.copy, size: 20),
                                    tooltip: t.htsCopyTooltip,
                                    onPressed: () {
                                      Clipboard.setData(ClipboardData(text: r.htsno));
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text(t.htsCopied(r.htsno)), duration: const Duration(seconds: 1)),
                                      );
                                    },
                                  ),
                            isThreeLine: r.htsno.isNotEmpty && r.description.isNotEmpty,
                          );
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
