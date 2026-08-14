import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../l10n/app_localizations.dart';
import '../theme.dart';

/// One labelled value on a detail page.
///
/// A field whose value is empty is dropped rather than drawn as a blank row:
/// EasyPost omits most optional fields on most records, and a page of labels
/// with nothing beside them reads as broken rather than as sparse.
class DetailField {
  final String label;
  final String value;
  const DetailField(this.label, this.value);
}

/// The page behind a row in History, Insurance, Claims or Pickups.
///
/// Those four lists were built from `ListTile`s carrying no `onTap`, so every
/// row in them was inert — four sections deep, the first thing anyone tries
/// does nothing. Tracking had a detail page from the start. This gives the
/// others the same behaviour without four near-identical screens, because what
/// each of them needs is a heading and a list of labelled values.
class ResourceDetailScreen extends StatelessWidget {
  /// What kind of record this is: "Shipment", "Claim", and so on.
  final String title;

  /// The record's own identifier, shown large and copyable.
  final String heading;

  final List<DetailField> fields;

  const ResourceDetailScreen({
    super.key,
    required this.title,
    required this.heading,
    required this.fields,
  });

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    final shown = fields.where((f) => f.value.trim().isNotEmpty).toList();
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
        children: [
          _Heading(text: heading),
          const SizedBox(height: 20),
          if (shown.isEmpty)
            Text(t.detailNothingFurther, style: const TextStyle(color: Brand.muted))
          else
            for (final field in shown) _FieldRow(field: field),
        ],
      ),
    );
  }
}

class _Heading extends StatelessWidget {
  final String text;
  const _Heading({required this.text});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: SelectableText(
            text,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        IconButton(
          icon: const Icon(Icons.copy, size: 20),
          tooltip: t.htsCopyTooltip,
          onPressed: () async {
            await Clipboard.setData(ClipboardData(text: text));
            if (!context.mounted) return;
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(t.htsCopied(text))));
          },
        ),
      ],
    );
  }
}

/// Label above value rather than beside it.
///
/// The labels are translated and their lengths diverge hard — "Pickup window"
/// is "Χρονικό παράθυρο παραλαβής" in Greek — so a two-column row would either
/// clip the label or starve the value. Stacking is also what right-to-left
/// languages want without any mirroring work.
class _FieldRow extends StatelessWidget {
  final DetailField field;
  const _FieldRow({required this.field});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            field.label.toUpperCase(),
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: Brand.muted,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 3),
          SelectableText(field.value, style: const TextStyle(fontSize: 15)),
        ],
      ),
    );
  }
}
