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

  /// ISO-2 country for the journey, from `carrier_detail`.
  ///
  /// Scan events do not always carry one — Royal Mail's domestic scans give a
  /// city and nothing else — and geocoding a bare city name without a country
  /// is what put a Watford delivery in Brazil. This is the fallback that keeps
  /// those pins on the map instead of dropping them.
  final String? fallbackCountry;

  /// The shipment this tracker was created for, when it came from a label.
  ///
  /// A tracker carries no address of its own, so this is the only route from a
  /// parcel to its recipient. A tracker added by tracking number alone has no
  /// shipment and therefore no recipient — see [toAddressFor] for why it is not
  /// matched to one by tracking code instead.
  final String? shipmentId;

  Tracker({
    required this.id,
    required this.trackingCode,
    required this.carrier,
    required this.status,
    this.statusDetail,
    this.estDelivery,
    this.updatedAt,
    this.signedBy,
    this.fallbackCountry,
    this.shipmentId,
    this.events = const [],
  });

  factory Tracker.fromJson(Map<String, dynamic> j) {
    final details = (j['tracking_details'] as List<dynamic>? ?? const [])
        .whereType<Map<String, dynamic>>()
        .map(TrackEvent.fromJson)
        .toList()
      ..sort((a, b) => (a.datetime ?? DateTime(1970)).compareTo(b.datetime ?? DateTime(1970)));
    // Destination first, then origin: a domestic parcel makes them the same,
    // and for an international one the destination is where most scans are.
    final carrierDetail = j['carrier_detail'] as Map<String, dynamic>?;
    String? locCountry(String key) {
      final loc = carrierDetail?[key] as Map<String, dynamic>?;
      final c = loc?['country']?.toString().trim();
      return (c == null || c.isEmpty) ? null : c;
    }

    return Tracker(
      fallbackCountry: locCountry('destination_tracking_location') ??
          locCountry('origin_tracking_location') ??
          // Any event that did carry one.
          details
              .map((e) => e.country?.trim())
              .firstWhere((c) => c != null && c.isNotEmpty, orElse: () => null) ??
          // The tracking number itself, when it is an S10.
          s10Country((j['tracking_code'] ?? '').toString()) ??
          // Failing everything, the carrier's own country.
          carrierCountry((j['carrier'] ?? '').toString()),
      id: (j['id'] ?? '').toString(),
      trackingCode: (j['tracking_code'] ?? '—').toString(),
      carrier: (j['carrier'] ?? '').toString(),
      status: (j['status'] ?? 'unknown').toString(),
      statusDetail: j['status_detail']?.toString(),
      estDelivery: DateTime.tryParse((j['est_delivery_date'] ?? '').toString()),
      updatedAt: DateTime.tryParse((j['updated_at'] ?? '').toString()),
      signedBy: j['signed_by']?.toString(),
      shipmentId: switch (j['shipment_id']?.toString().trim()) {
        final String id when id.isNotEmpty => id,
        _ => null,
      },
      events: details,
    );
  }
}

/// The origin country encoded in a UPU S10 tracking number.
///
/// S10 is two letters for the service, nine digits, then the ISO 3166-1 alpha-2
/// country of origin — so `OK828900054GB` ends in the answer. Royal Mail's
/// domestic scans carry a city and nothing else, and `carrier_detail` was empty
/// on the tracker that exposed this, so the number was the only place the
/// country existed.
///
/// Origin, strictly, not the country of every scan. That is the right trade for
/// a fallback: it is only consulted when nothing else said, and a geocode
/// constrained to the wrong country returns nothing rather than something
/// wrong.
String? s10Country(String trackingCode) {
  final t = trackingCode.trim().toUpperCase().replaceAll(RegExp(r'\s'), '');
  final m = RegExp(r'^[A-Z]{2}\d{9}([A-Z]{2})$').firstMatch(t);
  return m?.group(1);
}

/// Where a carrier's own network runs, for carriers that run in one country.
///
/// Deliberately short and deliberately excludes carriers that deliver
/// internationally under their own name — DHL, FedEx and UPS scan parcels on
/// every continent, so their country cannot be inferred from the carrier alone.
/// Consulted only after everything else has failed.
String? carrierCountry(String carrier) {
  switch (carrier.trim().toLowerCase().replaceAll(RegExp(r'[^a-z]'), '')) {
    case 'royalmail':
    case 'royalmailv':
    case 'parcelforce':
    case 'evri':
    case 'hermesuk':
    case 'dpduk':
    case 'yodel':
      return 'GB';
    case 'usps':
      return 'US';
    case 'canadapost':
    case 'postescanada':
      return 'CA';
    case 'australiapost':
      return 'AU';
    case 'anpost':
      return 'IE';
    case 'nzpost':
      return 'NZ';
    default:
      return null;
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

/// The translated status of a tracker or shipment record, or nothing when it
/// carries none.
///
/// Shipments share the tracker vocabulary, and History once printed it
/// verbatim — "delivered" beside a Tracking row reading "Livré" for the same
/// parcel. An absent status stays absent rather than becoming "Unknown":
/// stamping a word on every unlabelled record asserts something the API did
/// not say.
///
/// Only for trackers and shipments. Pickups, insurance and claims each have a
/// vocabulary of their own — see [pickupStatusText], [insuranceStatusText] and
/// [claimStatusText] — and passing them here put "Unknown" on every one.
String statusText(AppLocalizations t, Object? raw) {
  final status = (raw ?? '').toString().trim();
  return status.isEmpty ? '' : statusLabel(t, status);
}

/// Shared shape of the per-resource `…StatusText` functions: trimmed, blank
/// stays blank, anything else goes through that resource's own label.
String _statusTextWith(
  AppLocalizations t,
  Object? raw,
  String Function(AppLocalizations, String) label,
) {
  final status = (raw ?? '').toString().trim();
  return status.isEmpty ? '' : label(t, status);
}

/// A pickup's status, from EasyPost's Pickup object: `scheduled`, `canceled`
/// or `unknown`.
///
/// `canceled` is EasyPost's US spelling here, where trackers and insurance use
/// `cancelled`. The British spelling is accepted as well, so that neither
/// spelling can ever reach the reader as "Unknown".
String pickupStatusLabel(AppLocalizations t, String status) {
  switch (status) {
    case 'scheduled':
      return t.pickupStatusScheduled;
    case 'canceled':
    case 'cancelled':
      return t.pickupStatusCanceled;
    default:
      return t.statusUnknown;
  }
}

String pickupStatusText(AppLocalizations t, Object? raw) =>
    _statusTextWith(t, raw, pickupStatusLabel);

/// An insurance policy's status, from EasyPost's Insurance object: `new`,
/// `pending`, `purchased`, `failed` or `cancelled`.
String insuranceStatusLabel(AppLocalizations t, String status) {
  switch (status) {
    case 'new':
      return t.insuranceStatusNew;
    case 'pending':
      return t.insuranceStatusPending;
    case 'purchased':
      return t.insuranceStatusPurchased;
    case 'failed':
      return t.insuranceStatusFailed;
    case 'cancelled':
    case 'canceled':
      return t.insuranceStatusCancelled;
    default:
      return t.statusUnknown;
  }
}

String insuranceStatusText(AppLocalizations t, Object? raw) =>
    _statusTextWith(t, raw, insuranceStatusLabel);

/// A claim's status, from EasyPost's Claim object: `submitted`, `in_review`,
/// `approved`, `approved_partial`, `rejected`, `cancelled` or `needs_action`.
///
/// `approved_partial` gets its own words rather than folding into "Approved":
/// a claim paid in part is the one a shipper most needs to notice.
String claimStatusLabel(AppLocalizations t, String status) {
  switch (status) {
    case 'submitted':
      return t.claimStatusSubmitted;
    case 'in_review':
      return t.claimStatusInReview;
    case 'approved':
      return t.claimStatusApproved;
    case 'approved_partial':
      return t.claimStatusApprovedPartial;
    case 'rejected':
      return t.claimStatusRejected;
    case 'cancelled':
    case 'canceled':
      return t.claimStatusCancelled;
    case 'needs_action':
      return t.claimStatusNeedsAction;
    default:
      return t.statusUnknown;
  }
}

String claimStatusText(AppLocalizations t, Object? raw) =>
    _statusTextWith(t, raw, claimStatusLabel);

/// A refund request's own three-value vocabulary, which is not the shipment
/// one.
///
/// `refund_status` on a shipment is `submitted`, `refunded` or `rejected`, and
/// none of those means what the identically-shaped shipment statuses above
/// mean — a parcel is never "refunded" and a refund is never "delivered".
/// Folding them into [statusLabel] would have put "Unknown" on every refund, or
/// worse, taught that table words that then leaked onto a tracking row.
///
/// Total, like [statusLabel]: a value EasyPost adds later reads as words rather
/// than as an identifier.
String refundStatusLabel(AppLocalizations t, String status) {
  switch (status) {
    case 'submitted':
      return t.refundStatusSubmitted;
    case 'refunded':
      return t.refundStatusRefunded;
    case 'rejected':
      return t.refundStatusRejected;
    default:
      return t.statusUnknown;
  }
}

/// The translated refund status of a raw record, or nothing when it carries
/// none — which is also how a shipment with no refund request reads.
String refundStatusText(AppLocalizations t, Object? raw) {
  final status = (raw ?? '').toString().trim();
  return status.isEmpty ? '' : refundStatusLabel(t, status);
}

/// Icon and colour for a refund request. Submitted is the waiting state and
/// carries the same purple as `pre_transit`, for the same reason: nothing has
/// happened yet.
StatusStyle refundStatusStyle(String status) {
  switch (status) {
    case 'submitted':
      return const StatusStyle(Icons.hourglass_top, Color(0xFF8E5AD6));
    case 'refunded':
      return const StatusStyle(Icons.undo, Color(0xFF2E7D32));
    case 'rejected':
      return const StatusStyle(Icons.block, Color(0xFFC62828));
    default:
      return const StatusStyle(Icons.help_outline, Color(0xFF757575));
  }
}

/// Sort order for the refunds list: what is still waiting first, then what was
/// refused, then what is settled.
///
/// Deliberately not newest-first. A refund request is a thing somebody is
/// waiting on, and the two that need a person — still pending, and refused —
/// are the two that a date sort would bury under everything already resolved.
int refundStatusOrder(String status) {
  const order = ['submitted', 'rejected', 'refunded'];
  final i = order.indexOf(status);
  return i < 0 ? order.length : i;
}

/// The refund state a shipment record carries, or '' for the ordinary case of
/// a label nobody has asked to refund.
String refundStateOf(Map<String, dynamic> shipment) =>
    (shipment['refund_status'] ?? '').toString().trim();

/// The Refunds list: every shipment with a refund request on it, ordered by
/// [refundStatusOrder] and then newest first.
///
/// Derived from the shipments collection rather than from EasyPost's
/// `/refunds`, which is a different object that this account never creates.
/// Easy-Post Desktop asks for a refund with `POST /shipments/{id}/refund` —
/// `refund_shipment` in its `app/services/shipments.py` — which sets
/// `refund_status` on the shipment and returns the shipment. `/refunds` holds
/// objects made by `POST /refunds` with a carrier and a list of tracking codes,
/// which nothing in this product does. A tab built on that endpoint would have
/// been permanently empty and read as a broken app rather than as an absence of
/// refunds.
///
/// Two further consequences worth having: the proxy already allows
/// `GET /shipments`, so this needs no backend change and adds no cross-repo
/// contract; and each row arrives with its rate attached, so the screen can say
/// what sum is at stake without a second call.
List<Map<String, dynamic>> refundRequests(
  List<Map<String, dynamic>> shipments,
) {
  DateTime created(Map<String, dynamic> m) =>
      DateTime.tryParse((m['created_at'] ?? '').toString()) ??
      // Epoch zero for an unparseable date, so the row sorts last rather than
      // being dropped. A missing timestamp is not worth losing a refund over.
      DateTime.fromMillisecondsSinceEpoch(0);

  final rows = shipments.where((s) => refundStateOf(s).isNotEmpty).toList();
  rows.sort((a, b) {
    final byState = refundStatusOrder(
      refundStateOf(a),
    ).compareTo(refundStatusOrder(refundStateOf(b)));
    return byState != 0 ? byState : created(b).compareTo(created(a));
  });
  return rows;
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
  // What EasyPost's tracker endpoint accepts and echoes back for DHL eCommerce,
  // and therefore what a tracker created by Easy-Post Desktop carries.
  'dhlecs': 'DHL eCommerce',
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
  if (byCurrency.isEmpty) {
    return NumberFormat.decimalPatternDigits(locale: locale, decimalDigits: 2).format(0);
  }
  final entries = byCurrency.entries.toList()
    ..sort((a, b) => b.value.compareTo(a.value));
  return entries
      .map((e) => formatMoney(e.value, currency: e.key, locale: locale))
      .join(' · ');
}

/// A postal address on one line: "Acme Ltd, 10 Downing Street, London, GB".
///
/// EasyPost address objects use empty strings as readily as nulls and any line
/// may be absent, so the parts are filtered and joined rather than templated —
/// a template prints a trail of orphaned commas for every field the address
/// does not carry. Repeats are dropped too, because `name` and `company` are
/// frequently the same string and printing it twice looks like a bug.
///
/// [fields] exists so that the short form, [formatPlace], is this function
/// and not a second formatter. History's list used to carry one of its own,
/// and the desktop app's worst display defect was exactly that shape: one
/// screen formatted a value properly while every other screen showed it raw.
String formatAddress(Object? address, {List<String> fields = _addressFields}) {
  if (address is! Map) return '';
  final seen = <String>{};
  final parts = <String>[];
  for (final field in fields) {
    final value = address[field]?.toString().trim() ?? '';
    if (value.isEmpty || !seen.add(value.toLowerCase())) continue;
    parts.add(value);
  }
  return parts.join(', ');
}

const List<String> _addressFields = <String>[
  'name',
  'company',
  'street1',
  'street2',
  'city',
  'state',
  'zip',
  'country',
];

/// Where a parcel is going, in the space a list row has for it.
///
/// No name and no street: a row already carries a tracking number, a carrier
/// and a status, and the whole address is one tap away on the detail page.
/// History and Tracking both print this, so one parcel reads the same in both.
String formatPlace(Object? address) =>
    formatAddress(address, fields: const <String>['city', 'state', 'country']);

/// The shipments a tracker can be joined to, keyed by shipment id.
///
/// Built from the shipments collection in one pass rather than by fetching a
/// shipment per tracker, which would multiply the requests by the length of
/// the list. The proxy already allows the collection, for History.
///
/// The whole record is kept, not one field of it: the recipient, the date the
/// label was bought and any refund request all live on it, and a map per
/// field would be three joins that could disagree with each other.
Map<String, Map<String, dynamic>> shipmentsById(List<Map<String, dynamic>> shipments) =>
    <String, Map<String, dynamic>>{
      for (final s in shipments)
        if ((s['id'] ?? '').toString().isNotEmpty) s['id'].toString(): s,
    };

/// The shipment a tracked parcel came from, or null when nothing says which.
///
/// Joined on [Tracker.shipmentId] and on nothing else. A tracker added by
/// tracking number alone has no shipment, and pairing it with a shipment that
/// happens to share its tracking code would be a guess: carriers reissue
/// numbers, so a match on the number is not a match on the parcel. Showing
/// nothing is honest about that, where somebody else's address, purchase date
/// or refund would not be.
Map<String, dynamic>? shipmentFor(
  Tracker tracker,
  Map<String, Map<String, dynamic>> shipments,
) {
  final id = tracker.shipmentId;
  return id == null ? null : shipments[id];
}

/// The premium an insurance record was charged, or null when it has none.
///
/// EasyPost nests it: `fee` is a Fee object whose `amount` is the figure. A
/// bare number is accepted too, so an older or simplified record still shows.
Object? insuranceFeeAmount(Map<String, dynamic> insurance) {
  final fee = insurance['fee'];
  return fee is Map ? fee['amount'] : fee;
}

/// One money value with its currency: "5,000.00 USD".
///
/// EasyPost returns amounts as strings carrying five decimal places, so a five
/// thousand dollar insurance policy arrives as the string "5000.00000". Passed
/// straight into a widget that produced "$5000.00000" — no thousands
/// separator, three digits of invented precision, and a dollar sign hardcoded
/// regardless of what the figure is actually denominated in.
///
/// Presentation deliberately matches [formatSpend]: grouped by the locale's own
/// rules, two decimals, and the currency as a code rather than a symbol. One
/// money idiom across the app, and no symbol asserted for a currency the API
/// did not name.
///
/// Returns an empty string when the amount is absent or unparseable, rather
/// than "0.00" — a missing figure and a zero figure are different claims, and
/// only one of them is safe to put on screen.
String formatMoney(Object? amount, {String currency = 'USD', String locale = 'en'}) {
  if (amount == null) return '';
  final value =
      amount is num ? amount.toDouble() : double.tryParse(amount.toString().trim());
  if (value == null) return '';
  final number = NumberFormat.decimalPatternDigits(locale: locale, decimalDigits: 2);
  final code = currency.trim().toUpperCase();
  return code.isEmpty ? number.format(value) : '${number.format(value)} $code';
}
