import 'tracker.dart' show formatSpend, refundStateOf;

/// What Reports shows, derived from the shipments collection with no widget
/// and no network, so the arithmetic can be tested on its own.
///
/// Spend is kept per currency, not as one number. It used to be a single total
/// labelled with whichever currency the first shipment happened to carry, so a
/// parcel in dollars and two in pounds were added together and called dollars.
class SpendReport {
  /// Bought labels that still count as spend.
  int count = 0;
  final Map<String, double> spendByCurrency = {};
  final Map<String, int> carrierCount = {};

  /// Keyed by carrier, then currency: a carrier can be paid in more than one.
  final Map<String, Map<String, double>> carrierSpend = {};

  /// Labels with a refund asked for and not yet settled, per currency.
  final Map<String, double> pendingRefundsByCurrency = {};

  String spendLabel(String locale) =>
      formatSpend(spendByCurrency, locale: locale);

  String carrierSpendLabel(String carrier, String locale) =>
      formatSpend(carrierSpend[carrier] ?? const {}, locale: locale);

  String pendingRefundsLabel(String locale) =>
      formatSpend(pendingRefundsByCurrency, locale: locale);
}

/// Total spend, by currency and by carrier, from a list of shipment records.
///
/// * **Only bought labels count.** A shipment with no `selected_rate` was never
///   paid for, yet it was counted as a shipment.
/// * **A refunded label is not spend.** Reports counted every label ever bought,
///   so a shipper who voided unused labels saw an inflated figure — the one
///   figure on the screen used for bookkeeping. The demo account read
///   71.90 GBP where 67.75 GBP had actually been spent.
/// * **A pending refund is still spend, and is shown beside it.** The money has
///   not come back and the carrier may yet refuse, so removing it would
///   understate; showing it separately says how much may return. A rejected
///   refund is ordinary spend.
/// * **Currencies are never summed together**, and no conversion is attempted:
///   that would need a rate this app has no business inventing.
SpendReport buildSpendReport(List<Map<String, dynamic>> shipments) {
  final r = SpendReport();
  for (final s in shipments) {
    final rate = s['selected_rate'];
    if (rate is! Map) continue;
    final refund = refundStateOf(s);
    if (refund == 'refunded') continue;
    final amount = double.tryParse('${rate['rate'] ?? ''}') ?? 0;
    final carrier = (rate['carrier'] ?? '').toString();
    final currency = (rate['currency'] ?? '').toString().trim().toUpperCase();
    r.count++;
    r.spendByCurrency[currency] = (r.spendByCurrency[currency] ?? 0) + amount;
    r.carrierCount[carrier] = (r.carrierCount[carrier] ?? 0) + 1;
    final byCurrency = r.carrierSpend.putIfAbsent(carrier, () => {});
    byCurrency[currency] = (byCurrency[currency] ?? 0) + amount;
    if (refund == 'submitted') {
      r.pendingRefundsByCurrency[currency] =
          (r.pendingRefundsByCurrency[currency] ?? 0) + amount;
    }
  }
  return r;
}
