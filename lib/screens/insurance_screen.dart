import 'package:flutter/material.dart';

import '../services/pairing_store.dart';
import '../services/proxy_client.dart';
import 'home_shell.dart';

class InsuranceScreen extends StatefulWidget {
  final AppNav nav;
  final PairingCredentials creds;
  const InsuranceScreen({super.key, required this.nav, required this.creds});

  @override
  State<InsuranceScreen> createState() => _InsuranceScreenState();
}

class _InsuranceScreenState extends State<InsuranceScreen> {
  final _proxy = ProxyClient();
  late Future<List<Map<String, dynamic>>> _future;

  @override
  void initState() {
    super.initState();
    _future = _proxy.getInsurances(widget.creds);
  }

  Future<void> _refresh() async {
    final f = _proxy.getInsurances(widget.creds);
    setState(() => _future = f);
    await f.catchError((_) => <Map<String, dynamic>>[]);
  }

  Future<void> _openForm() async {
    final created = await Navigator.of(context).push<bool>(
      MaterialPageRoute(builder: (_) => _InsuranceForm(creds: widget.creds, proxy: _proxy)),
    );
    if (created == true) _refresh();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Insurance')),
      drawer: NavDrawer(nav: widget.nav),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _openForm,
        icon: const Icon(Icons.add),
        label: const Text('Buy insurance'),
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
              return ListView(children: const [Padding(padding: EdgeInsets.all(24), child: Text('No insurance policies yet. Tap “Buy insurance”.', textAlign: TextAlign.center))]);
            }
            return ListView.separated(
              itemCount: items.length,
              separatorBuilder: (_, _) => const Divider(height: 1),
              itemBuilder: (context, i) {
                final m = items[i];
                return ListTile(
                  title: Text((m['tracking_code'] ?? m['id'] ?? '—').toString(), style: const TextStyle(fontWeight: FontWeight.w600)),
                  subtitle: Text((m['provider'] ?? m['carrier'] ?? '').toString()),
                  trailing: Text(m['amount'] == null ? '' : '\$${m['amount']}'),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class _InsuranceForm extends StatefulWidget {
  final PairingCredentials creds;
  final ProxyClient proxy;
  const _InsuranceForm({required this.creds, required this.proxy});

  @override
  State<_InsuranceForm> createState() => _InsuranceFormState();
}

class _AddressFields {
  final name = TextEditingController();
  final street1 = TextEditingController();
  final city = TextEditingController();
  final state = TextEditingController();
  final zip = TextEditingController();
  final country = TextEditingController(text: 'US');

  Map<String, String> toMap() => {
        'name': name.text.trim(),
        'street1': street1.text.trim(),
        'city': city.text.trim(),
        'state': state.text.trim(),
        'zip': zip.text.trim(),
        'country': country.text.trim(),
      };

  void dispose() {
    for (final c in [name, street1, city, state, zip, country]) {
      c.dispose();
    }
  }
}

class _InsuranceFormState extends State<_InsuranceForm> {
  final _form = GlobalKey<FormState>();
  final _tracking = TextEditingController();
  final _carrier = TextEditingController();
  final _amount = TextEditingController();
  final _from = _AddressFields();
  final _to = _AddressFields();
  bool _busy = false;

  @override
  void dispose() {
    _tracking.dispose();
    _carrier.dispose();
    _amount.dispose();
    _from.dispose();
    _to.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_form.currentState!.validate()) return;
    setState(() => _busy = true);
    try {
      await widget.proxy.buyInsurance(widget.creds, {
        'tracking_code': _tracking.text.trim(),
        'carrier': _carrier.text.trim(),
        'amount': _amount.text.trim(),
        'from_address': _from.toMap(),
        'to_address': _to.toMap(),
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

  Widget _field(TextEditingController c, String label, {bool required = true, TextInputType? kb}) => Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: TextFormField(
          controller: c,
          keyboardType: kb,
          decoration: InputDecoration(labelText: label, border: const OutlineInputBorder()),
          validator: required ? (v) => (v == null || v.trim().isEmpty) ? 'Required' : null : null,
        ),
      );

  List<Widget> _address(String heading, _AddressFields a) => [
        Padding(
          padding: const EdgeInsets.only(top: 8, bottom: 8),
          child: Text(heading, style: const TextStyle(fontWeight: FontWeight.w700)),
        ),
        _field(a.name, 'Name'),
        _field(a.street1, 'Street'),
        _field(a.city, 'City'),
        _field(a.state, 'State / region', required: false),
        _field(a.zip, 'Postcode'),
        _field(a.country, 'Country (ISO, e.g. US)'),
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Buy insurance')),
      body: Form(
        key: _form,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _field(_tracking, 'Tracking code'),
            _field(_carrier, 'Carrier (e.g. USPS)'),
            _field(_amount, 'Insured amount (USD)', kb: const TextInputType.numberWithOptions(decimal: true)),
            ..._address('From address', _from),
            ..._address('To address', _to),
            const SizedBox(height: 8),
            FilledButton(
              onPressed: _busy ? null : _submit,
              child: _busy
                  ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2))
                  : const Text('Buy insurance'),
            ),
          ],
        ),
      ),
    );
  }
}
