import 'package:flutter/material.dart';

import '../services/pairing_store.dart';
import '../services/proxy_client.dart';
import 'home_shell.dart';

class ClaimsScreen extends StatefulWidget {
  final AppNav nav;
  final PairingCredentials creds;
  const ClaimsScreen({super.key, required this.nav, required this.creds});

  @override
  State<ClaimsScreen> createState() => _ClaimsScreenState();
}

class _ClaimsScreenState extends State<ClaimsScreen> {
  final _proxy = ProxyClient();
  late Future<List<Map<String, dynamic>>> _future;

  @override
  void initState() {
    super.initState();
    _future = _proxy.getClaims(widget.creds);
  }

  Future<void> _refresh() async {
    final f = _proxy.getClaims(widget.creds);
    setState(() => _future = f);
    await f.catchError((_) => <Map<String, dynamic>>[]);
  }

  Future<void> _openForm() async {
    final created = await Navigator.of(context).push<bool>(
      MaterialPageRoute(builder: (_) => _ClaimForm(creds: widget.creds, proxy: _proxy)),
    );
    if (created == true) _refresh();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Claims')),
      drawer: NavDrawer(nav: widget.nav),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _openForm,
        icon: const Icon(Icons.add),
        label: const Text('File a claim'),
      ),
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
              return ListView(children: const [Padding(padding: EdgeInsets.all(24), child: Text('No claims filed yet. Tap “File a claim”.', textAlign: TextAlign.center))]);
            }
            return ListView.separated(
              itemCount: items.length,
              separatorBuilder: (_, _) => const Divider(height: 1),
              itemBuilder: (context, i) {
                final m = items[i];
                return ListTile(
                  title: Text((m['tracking_code'] ?? m['id'] ?? '—').toString(), style: const TextStyle(fontWeight: FontWeight.w600)),
                  subtitle: Text((m['type'] ?? '').toString()),
                  trailing: Text((m['status'] ?? '').toString()),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class _ClaimForm extends StatefulWidget {
  final PairingCredentials creds;
  final ProxyClient proxy;
  const _ClaimForm({required this.creds, required this.proxy});

  @override
  State<_ClaimForm> createState() => _ClaimFormState();
}

class _ClaimFormState extends State<_ClaimForm> {
  final _form = GlobalKey<FormState>();
  final _tracking = TextEditingController();
  final _amount = TextEditingController();
  final _email = TextEditingController();
  final _description = TextEditingController();
  String _type = 'damage';
  bool _busy = false;

  @override
  void dispose() {
    _tracking.dispose();
    _amount.dispose();
    _email.dispose();
    _description.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_form.currentState!.validate()) return;
    setState(() => _busy = true);
    try {
      await widget.proxy.fileClaim(widget.creds, {
        'tracking_code': _tracking.text.trim(),
        'type': _type,
        'amount': _amount.text.trim(),
        'email': _email.text.trim(),
        'description': _description.text.trim(),
      });
      if (!mounted) return;
      Navigator.of(context).pop(true);
    } catch (e) {
      if (mounted) {
        setState(() => _busy = false);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('File a claim')),
      body: Form(
        key: _form,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              controller: _tracking,
              decoration: const InputDecoration(labelText: 'Tracking code', border: OutlineInputBorder()),
              validator: (v) => (v == null || v.trim().isEmpty) ? 'Required' : null,
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              initialValue: _type,
              decoration: const InputDecoration(labelText: 'Type', border: OutlineInputBorder()),
              items: const [
                DropdownMenuItem(value: 'damage', child: Text('Damage')),
                DropdownMenuItem(value: 'theft', child: Text('Theft')),
                DropdownMenuItem(value: 'loss', child: Text('Loss')),
              ],
              onChanged: (v) => setState(() => _type = v ?? 'damage'),
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _amount,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(labelText: 'Amount (USD)', border: OutlineInputBorder()),
              validator: (v) => (double.tryParse(v?.trim() ?? '') == null) ? 'Enter an amount' : null,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _email,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(labelText: 'Contact email', border: OutlineInputBorder()),
              validator: (v) => (v == null || !v.contains('@')) ? 'Enter an email' : null,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _description,
              maxLines: 3,
              decoration: const InputDecoration(labelText: 'Description', border: OutlineInputBorder()),
              validator: (v) => (v == null || v.trim().isEmpty) ? 'Describe the issue' : null,
            ),
            const SizedBox(height: 20),
            FilledButton(
              onPressed: _busy ? null : _submit,
              child: _busy
                  ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2))
                  : const Text('File claim'),
            ),
          ],
        ),
      ),
    );
  }
}
