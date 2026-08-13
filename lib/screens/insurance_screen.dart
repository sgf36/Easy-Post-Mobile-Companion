import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';
import '../services/error_text.dart';
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
    final t = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(t.navInsurance)),
      drawer: NavDrawer(nav: widget.nav),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _openForm,
        icon: const Icon(Icons.add),
        label: Text(t.insuranceBuy),
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
              return ListView(children: [Padding(padding: const EdgeInsets.all(24), child: Text(describeError(t, snap.error), textAlign: TextAlign.center))]);
            }
            final items = snap.data ?? const [];
            if (items.isEmpty) {
              return ListView(children: [Padding(padding: const EdgeInsets.all(24), child: Text(t.insuranceEmpty, textAlign: TextAlign.center))]);
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

  /// EasyPost caps declared insurance at 5,000 US dollars and always reads the
  /// amount as USD, whatever the shipment is priced in. Checked here so an
  /// over-limit figure is caught on the phone rather than coming back as an
  /// opaque API error after the user has committed to buying.
  static const double maxInsuranceUsd = 5000;

  Future<void> _submit() async {
    final t = AppLocalizations.of(context);
    if (!_form.currentState!.validate()) return;
    final amount = double.tryParse(_amount.text.trim());
    if (amount == null || amount <= 0 || amount > maxInsuranceUsd) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(t.insuranceAmountRange)),
      );
      return;
    }
    setState(() => _busy = true);
    try {
      await widget.proxy.buyInsurance(widget.creds, {
        'tracking_code': _tracking.text.trim(),
        'carrier': _carrier.text.trim(),
        'amount': amount.toStringAsFixed(2),
        'from_address': _from.toMap(),
        'to_address': _to.toMap(),
      });
      if (!mounted) return;
      Navigator.of(context).pop(true);
    } catch (e) {
      if (mounted) {
        setState(() => _busy = false);
        // This endpoint is standalone insurance, which is a per-account
        // permission. Where it is switched off EasyPost answers "Your account
        // is not enabled for standalone insurance purchase" — a setting to take
        // up with EasyPost, not a mistake the user just made, so it is worth
        // saying so, in the reader's language, rather than passing the raw
        // English error through as every other API failure is.
        final message = e.toString().contains('not enabled for standalone insurance')
            ? t.insuranceNotEnabled
            : describeError(t, e);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
      }
    }
  }

  Widget _field(AppLocalizations t, TextEditingController c, String label,
          {bool required = true, TextInputType? kb}) =>
      Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: TextFormField(
          controller: c,
          keyboardType: kb,
          decoration: InputDecoration(labelText: label, border: const OutlineInputBorder()),
          validator: required
              ? (v) => (v == null || v.trim().isEmpty) ? t.validationRequired : null
              : null,
        ),
      );

  List<Widget> _address(AppLocalizations t, String heading, _AddressFields a) => [
        Padding(
          padding: const EdgeInsets.only(top: 8, bottom: 8),
          child: Text(heading, style: const TextStyle(fontWeight: FontWeight.w700)),
        ),
        _field(t, a.name, t.fieldName),
        _field(t, a.street1, t.fieldStreet),
        _field(t, a.city, t.fieldCity),
        _field(t, a.state, t.fieldStateRegion, required: false),
        _field(t, a.zip, t.fieldPostcode),
        _field(t, a.country, t.fieldCountryIso),
      ];

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(t.insuranceBuy)),
      body: Form(
        key: _form,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _field(t, _tracking, t.fieldTrackingCode),
            _field(t, _carrier, t.fieldCarrierHint),
            _field(t, _amount, t.fieldInsuredAmount,
                kb: const TextInputType.numberWithOptions(decimal: true)),
            ..._address(t, t.insuranceFromAddress, _from),
            ..._address(t, t.insuranceToAddress, _to),
            const SizedBox(height: 8),
            FilledButton(
              onPressed: _busy ? null : _submit,
              child: _busy
                  ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2))
                  : Text(t.insuranceBuy),
            ),
          ],
        ),
      ),
    );
  }
}
