import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';
import '../models/tracker.dart';
import '../services/error_text.dart';
import '../services/pairing_store.dart';
import '../services/proxy_client.dart';
import '../theme.dart';
import 'home_shell.dart';
import 'resource_detail_screen.dart';

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
    final t = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(t.navClaims)),
      drawer: NavDrawer(nav: widget.nav),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _openForm,
        icon: const Icon(Icons.add),
        label: Text(t.claimsFile),
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
              return ListView(children: [Padding(padding: const EdgeInsets.all(24), child: Text(t.claimsEmpty, textAlign: TextAlign.center))]);
            }
            return ListView.separated(
              itemCount: items.length,
              separatorBuilder: (_, _) => const Divider(height: 1),
              itemBuilder: (context, i) {
                final m = items[i];
                final heading = (m['tracking_code'] ?? m['id'] ?? '—').toString();
                return ListTile(
                  title: Text(heading, style: const TextStyle(fontWeight: FontWeight.w600)),
                  subtitle: Text(_claimType(t, m['type'])),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(statusText(t, m['status'])),
                      const Padding(
                        padding: EdgeInsetsDirectional.only(start: 4),
                        child: Icon(Icons.chevron_right, size: 20, color: Brand.muted),
                      ),
                    ],
                  ),
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => ResourceDetailScreen(
                        title: t.detailClaim,
                        heading: heading,
                        fields: [
                          DetailField(t.fieldStatus, statusText(t, m['status'])),
                          DetailField(t.fieldType, _claimType(t, m['type'])),
                          DetailField(
                            t.fieldAmount,
                            formatMoney(m['requested_amount'] ?? m['amount'],
                                currency: (m['currency'] ?? 'USD').toString(),
                                locale: t.localeName),
                          ),
                          DetailField(t.fieldTrackingCode,
                              (m['tracking_code'] ?? '').toString()),
                          DetailField(t.fieldDescription,
                              (m['description'] ?? '').toString()),
                          DetailField(
                            t.fieldCreated,
                            formatDateTime(
                                DateTime.tryParse((m['created_at'] ?? '').toString()),
                                t.localeName),
                          ),
                        ],
                      ),
                    ),
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

/// The claim type in the reader's language.
///
/// EasyPost sends the enum — "damage" — and the list printed it raw, in
/// English, beside a status that does translate. Total by construction: an
/// unrecognised type is tidied rather than dropped, since hiding it would lose
/// the only thing distinguishing one claim from another.
String _claimType(AppLocalizations t, Object? raw) {
  final type = (raw ?? '').toString().trim();
  switch (type.toLowerCase()) {
    case 'damage':
      return t.claimTypeDamage;
    case 'theft':
      return t.claimTypeTheft;
    case 'loss':
      return t.claimTypeLoss;
    default:
      return type.replaceAll('_', ' ');
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

  /// Damage and theft claims are refused by EasyPost without at least one
  /// supporting document ("At least one supporting documentation attachment is
  /// required for theft or damage claims"). The phone cannot attach one yet, so
  /// this says so plainly instead of sending a request that always fails.
  bool get _needsAttachment => _type == 'damage' || _type == 'theft';

  Future<void> _submit() async {
    final t = AppLocalizations.of(context);
    if (!_form.currentState!.validate()) return;
    if (_needsAttachment) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(t.claimAttachmentSnack)),
      );
      return;
    }
    setState(() => _busy = true);
    try {
      await widget.proxy.fileClaim(widget.creds, {
        'tracking_code': _tracking.text.trim(),
        'type': _type,
        'amount': _amount.text.trim(),
        // `contact_email`, not `email`. EasyPost rejects the request outright
        // otherwise — "contact_email: field required" — so every claim filed
        // from the phone failed, whatever was typed here.
        'contact_email': _email.text.trim(),
        'description': _description.text.trim(),
      });
      if (!mounted) return;
      Navigator.of(context).pop(true);
    } catch (e) {
      if (mounted) {
        setState(() => _busy = false);
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(describeError(t, e))));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(t.claimsFile)),
      body: Form(
        key: _form,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              controller: _tracking,
              decoration: InputDecoration(
                  labelText: t.fieldTrackingCode, border: const OutlineInputBorder()),
              validator: (v) => (v == null || v.trim().isEmpty) ? t.validationRequired : null,
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              initialValue: _type,
              decoration:
                  InputDecoration(labelText: t.fieldType, border: const OutlineInputBorder()),
              items: [
                DropdownMenuItem(value: 'damage', child: Text(t.claimTypeDamage)),
                DropdownMenuItem(value: 'theft', child: Text(t.claimTypeTheft)),
                DropdownMenuItem(value: 'loss', child: Text(t.claimTypeLoss)),
              ],
              onChanged: (v) => setState(() => _type = v ?? 'damage'),
            ),
            if (_needsAttachment) ...[
              const SizedBox(height: 8),
              Text(t.claimAttachmentNote),
            ],
            const SizedBox(height: 12),
            TextFormField(
              controller: _amount,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(
                  labelText: t.fieldAmountUsd, border: const OutlineInputBorder()),
              validator: (v) =>
                  (double.tryParse(v?.trim() ?? '') == null) ? t.validationEnterAmount : null,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _email,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                  labelText: t.fieldContactEmail, border: const OutlineInputBorder()),
              validator: (v) => (v == null || !v.contains('@')) ? t.validationEnterEmail : null,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _description,
              maxLines: 3,
              decoration: InputDecoration(
                  labelText: t.fieldDescription, border: const OutlineInputBorder()),
              validator: (v) =>
                  (v == null || v.trim().isEmpty) ? t.validationDescribeIssue : null,
            ),
            const SizedBox(height: 20),
            FilledButton(
              onPressed: _busy ? null : _submit,
              child: _busy
                  ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2))
                  : Text(t.claimSubmit),
            ),
          ],
        ),
      ),
    );
  }
}
