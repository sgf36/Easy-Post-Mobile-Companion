import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../l10n/app_localizations.dart';

/// A shipment tracker, parsed from the EasyPost tracker object.
class Tracker {
  final String id;
  final String trackingCode;
  final String carrier;
  final String status;
  final String? statusDetail;
  final DateTime? estDelivery;
  final DateTime? updatedAt;
  final String? signedBy;
  final List<TrackEvent> events; // chronological (oldest first)

  Tracker({
    required this.id,
    required this.trackingCode,
    required this.carrier,
    required this.status,
    this.statusDetail,
    this.estDelivery,
    this.updatedAt,
    this.signedBy,
    this.events = const [],
  });

  factory Tracker.fromJson(Map<String, dynamic> j) {
    final details = (j['tracking_details'] as List<dynamic>? ?? const [])
        .whereType<Map<String, dynamic>>()
        .map(TrackEvent.fromJson)
        .toList()
      ..sort((a, b) => (a.datetime ?? DateTime(1970)).compareTo(b.datetime ?? DateTime(1970)));
    return Tracker(
      id: (j['id'] ?? '').toString(),
      trackingCode: (j['tracking_code'] ?? '—').toString(),
      carrier: (j['carrier'] ?? '').toString(),
      status: (j['status'] ?? 'unknown').toString(),
      statusDetail: j['status_detail']?.toString(),
      estDelivery: DateTime.tryParse((j['est_delivery_date'] ?? '').toString()),
      updatedAt: DateTime.tryParse((j['updated_at'] ?? '').toString()),
      signedBy: j['signed_by']?.toString(),
      events: details,
    );
  }
}

class TrackEvent {
  final String status;
  final String message;
  final DateTime? datetime;
  final String? city;
  final String? state;
  final String? country;
  final String? zip;

  TrackEvent({
    required this.status,
    required this.message,
    this.datetime,
    this.city,
    this.state,
    this.country,
    this.zip,
  });

  factory TrackEvent.fromJson(Map<String, dynamic> j) {
    final loc = j['tracking_location'] as Map<String, dynamic>? ?? const {};
    return TrackEvent(
      status: (j['status'] ?? 'unknown').toString(),
      message: (j['message'] ?? j['description'] ?? '').toString(),
      datetime: DateTime.tryParse((j['datetime'] ?? '').toString()),
      city: loc['city']?.toString(),
      state: loc['state']?.toString(),
      country: loc['country']?.toString(),
      zip: loc['zip']?.toString(),
    );
  }

  /// "HOUSTON, TX" style label, or null when no location is present.
  String? get locationLabel {
    final parts = [city, state].where((p) => p != null && p.trim().isNotEmpty).map((p) => p!.trim());
    return parts.isEmpty ? null : parts.join(', ');
  }
}

/// Visual treatment for an EasyPost tracker status.
///
/// Icon and colour only. The words live in the ARB catalogues, because a status
/// is ordinary prose — "in transit" is a sentence, not an identifier — whereas
/// a carrier name is a brand and stays as it is in every language. That split is
/// the same one the desktop app draws in `app/services/formatting.py`.
class StatusStyle {
  final IconData icon;
  final Color color;
  const StatusStyle(this.icon, this.color);
}

StatusStyle statusStyle(String status) {
  switch (status) {
    case 'pre_transit':
      return const StatusStyle(Icons.schedule, Color(0xFF8E5AD6));
    case 'in_transit':
      return const StatusStyle(Icons.local_shipping, Color(0xFF2B6CB0));
    case 'out_for_delivery':
      return const StatusStyle(Icons.moving, Color(0xFF00897B));
    case 'delivered':
      return const StatusStyle(Icons.check_circle, Color(0xFF2E7D32));
    case 'available_for_pickup':
      return const StatusStyle(Icons.storefront, Color(0xFF00838F));
    case 'return_to_sender':
      return const StatusStyle(Icons.keyboard_return, Color(0xFFF9A825));
    case 'failure':
      return const StatusStyle(Icons.error, Color(0xFFC62828));
    case 'cancelled':
      return const StatusStyle(Icons.cancel, Color(0xFF757575));
    case 'error':
      return const StatusStyle(Icons.report_problem, Color(0xFFC62828));
    default:
      return const StatusStyle(Icons.help_outline, Color(0xFF757575));
  }
}

/// The status as a reader sees it. Total: an unrecognised code reads "Unknown"
/// rather than leaking `in_transit` onto the screen, which is what the first
/// App Store capture did.
String statusLabel(AppLocalizations t, String status) {
  switch (status) {
    case 'pre_transit':
      return t.statusPreTransit;
    case 'in_transit':
      return t.statusInTransit;
    case 'out_for_delivery':
      return t.statusOutForDelivery;
    case 'delivered':
      return t.statusDelivered;
    case 'available_for_pickup':
      return t.statusAvailableForPickup;
    case 'return_to_sender':
      return t.statusReturnToSender;
    case 'failure':
      return t.statusFailure;
    case 'cancelled':
      return t.statusCancelled;
    case 'error':
      return t.statusError;
    default:
      return t.statusUnknown;
  }
}

/// Sort priority — journey order, ending with terminal/exception states.
int statusOrder(String status) {
  const order = [
    'pre_transit',
    'in_transit',
    'out_for_delivery',
    'available_for_pickup',
    'delivered',
    'return_to_sender',
    'failure',
    'error',
    'cancelled',
    'unknown',
  ];
  final i = order.indexOf(status);
  return i < 0 ? order.length : i;
}

/// Brand colour per carrier, with a deterministic fallback for the rest.
Color carrierColor(String carrier) {
  final c = carrier.toLowerCase();
  if (c.contains('usps')) return const Color(0xFF004B87);
  if (c.contains('ups')) return const Color(0xFF6B4A2B);
  if (c.contains('fedex')) return const Color(0xFF4D148C);
  if (c.contains('dhl')) return const Color(0xFFD40511);
  if (c.contains('royal') || c.contains('royalmail')) return const Color(0xFFDA291C);
  if (c.contains('canada')) return const Color(0xFFE31837);
  if (c.contains('amazon')) return const Color(0xFFEB8A00);
  if (c.contains('ontrac')) return const Color(0xFF00539B);
  if (c.contains('lasership')) return const Color(0xFF6A1B9A);
  if (c.contains('dpd')) return const Color(0xFFDC0032);
  if (c.contains('hermes') || c.contains('evri')) return const Color(0xFF00A5A5);
  if (c.trim().isEmpty) return const Color(0xFF607D8B);
  const palette = [
    Color(0xFF00695C),
    Color(0xFF283593),
    Color(0xFFAD1457),
    Color(0xFF4E342E),
    Color(0xFF37474F),
    Color(0xFF558B2F),
  ];
  return palette[carrier.hashCode.abs() % palette.length];
}

/// "27 Jun 2026, 09:28" in English, and whatever the locale writes elsewhere.
///
/// The month names and the field order both move: Japanese wants 2026年6月27日,
/// not a translated "Jun" dropped into an English frame. `intl` has the data,
/// and `flutter_localizations` has already initialised it for the active locale
/// by the time any of this is built.
String formatDateTime(DateTime? dt, String locale) {
  if (dt == null) return '';
  return DateFormat.yMMMd(locale).add_Hm().format(dt.toLocal());
}

String formatDate(DateTime? dt, String locale) {
  if (dt == null) return '';
  return DateFormat.yMMMd(locale).format(dt.toLocal());
}

/// Day and month, no year: "15 Aug", "15. Aug.", "8月15日".
///
/// For the tracker list, where the row already carries a carrier name and a
/// status badge and the year is four characters of nothing. With the full date
/// there, a German capture read "Royal Mail V3 · Voraussichtlich 1…" on nine
/// rows out of eleven — the year was pushing the useful part off the screen.
String formatDateShort(DateTime? dt, String locale) {
  if (dt == null) return '';
  return DateFormat.MMMd(locale).format(dt.toLocal());
}

/// Human-readable carrier name.
///
/// EasyPost returns the integration's code, not a name: "RoyalMailV3",
/// "DHLExpress". Printed raw beside a brand colour it reads as an internal
/// identifier leaking onto the screen, which is exactly how it looked on the
/// first App Store capture.
///
/// The desktop app fixed the same class of defect in 6070f4a. The bug there was
/// subtler and worth not repeating: the caller decided whether a carrier had
/// been recognised by comparing the humanised result with the input, so any
/// carrier whose display name *is* its code — FedEx, USPS — was treated as
/// unrecognised and camel-split into "Fed Ex". This function is total: it
/// always returns something printable and never asks the caller to infer
/// success from the value.
String carrierDisplayName(String carrier) {
  if (carrier.isEmpty) return '';
  final known = _carrierNames[carrier.toLowerCase()];
  if (known != null) return known;
  // Fallback for codes not in the table: split camel case only. Digits stay
  // attached to the letter before them, so "RoyalMailV3" ends "V3" and not
  // "V 3" — a version suffix is not a separate word.
  return carrier.replaceAllMapped(
    RegExp(r'([a-z])([A-Z])'),
    (m) => '${m[1]} ${m[2]}',
  );
}

const _carrierNames = <String, String>{
  'usps': 'USPS',
  'ups': 'UPS',
  'upsdap': 'UPS',
  'fedex': 'FedEx',
  'fedexdefault': 'FedEx',
  'dhlexpress': 'DHL Express',
  'dhlecommerce': 'DHL eCommerce',
  'royalmail': 'Royal Mail',
  'royalmailv3': 'Royal Mail V3',
  'evri': 'Evri',
  'hermes': 'Evri',
  'canadapost': 'Canada Post',
  'ontrac': 'OnTrac',
  'lasership': 'LaserShip',
  'dpd': 'DPD',
  'dpduk': 'DPD UK',
  'amazonmws': 'Amazon',
  'parcelforce': 'Parcelforce',
  'yodel': 'Yodel',
};

/// The finer-grained status line, or null when it says nothing.
///
/// EasyPost sets `status_detail` to "unknown" whenever it has nothing more
/// specific than the status itself, which is most of the time. Printed verbatim
/// under a status badge it reads as the app not knowing what is happening,
/// rather than the carrier not having elaborated — so it is omitted instead.
///
/// Also dropped when it merely restates the status: "in_transit" under a badge
/// already reading "In transit" is noise, not detail.
String? statusDetailText(String status, String? statusDetail) {
  final d = (statusDetail ?? '').trim();
  if (d.isEmpty) return null;
  final normalised = d.toLowerCase().replaceAll(' ', '_');
  if (normalised == 'unknown' || normalised == status.toLowerCase()) return null;
  return d.replaceAll('_', ' ');
}

/// Money totals that may span more than one currency: "18.05 GBP · 8.40 USD".
///
/// Ordered largest first. Kept separate rather than summed because converting
/// between currencies needs a rate, and an app that invents one states a figure
/// it cannot stand behind.
///
/// [locale] decides the decimal separator, so a German reader sees "57,00 GBP"
/// rather than the "57.00 GBP" a hardcoded `toStringAsFixed` produced — which
/// in German is not a near miss but a different number. It defaults to English
/// so the pure formatting tests need not carry a locale around.
String formatSpend(Map<String, double> byCurrency, {String locale = 'en'}) {
  final number = NumberFormat.decimalPatternDigits(locale: locale, decimalDigits: 2);
  if (byCurrency.isEmpty) return number.format(0);
  final entries = byCurrency.entries.toList()
    ..sort((a, b) => b.value.compareTo(a.value));
  return entries
      .map((e) => '${number.format(e.value)}${e.key.isEmpty ? '' : ' ${e.key}'}')
      .join(' · ');
}
