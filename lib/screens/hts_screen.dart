import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
    return Scaffold(
      appBar: AppBar(title: const Text('HTS Lookup')),
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
                    decoration: const InputDecoration(
                      labelText: 'Search tariff codes',
                      hintText: 'e.g. copper wire',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                FilledButton(onPressed: _search, child: const Text('Search')),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(16, 0, 16, 8),
            child: Text(
              'Reference lookup from the U.S. International Trade Commission. Correct classification remains the shipper’s responsibility.',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ),
          Expanded(
            child: _future == null
                ? const Center(child: Text('Search for a tariff code above.'))
                : FutureBuilder<List<HtsResult>>(
                    future: _future,
                    builder: (context, snap) {
                      if (snap.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (snap.hasError) {
                        return Padding(
                          padding: const EdgeInsets.all(24),
                          child: Text('${snap.error}', textAlign: TextAlign.center),
                        );
                      }
                      final rows = snap.data ?? const [];
                      if (rows.isEmpty) {
                        return const Padding(
                          padding: EdgeInsets.all(24),
                          child: Text('No matching tariff codes.', textAlign: TextAlign.center),
                        );
                      }
                      return ListView.separated(
                        itemCount: rows.length,
                        separatorBuilder: (_, _) => const Divider(height: 1),
                        itemBuilder: (context, i) {
                          final r = rows[i];
                          final rates = [
                            if (r.general.isNotEmpty) 'General ${r.general}',
                            if (r.special.isNotEmpty) 'Special ${r.special}',
                            if (r.other.isNotEmpty) 'Other ${r.other}',
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
                                    tooltip: 'Copy code',
                                    onPressed: () {
                                      Clipboard.setData(ClipboardData(text: r.htsno));
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text('Copied ${r.htsno}'), duration: const Duration(seconds: 1)),
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
