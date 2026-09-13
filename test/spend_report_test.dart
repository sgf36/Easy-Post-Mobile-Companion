// Reports "Total spend" is the figure a shipper takes to their books.
//
// 1.3.0 added every label ever bought, refunded or not, so the demo account
// read 71.90 GBP where 67.75 GBP had been spent.
import 'package:easypost_mobile_companion/models/spend_report.dart';
import 'package:easypost_mobile_companion/services/demo_fixtures.dart';
import 'package:flutter_test/flutter_test.dart';

Map<String, dynamic> label(
  String id,
  String rate,
  String currency, {
  String carrier = 'USPS',
  String? refund,
}) => {
  'id': id,
  'selected_rate': {'carrier': carrier, 'rate': rate, 'currency': currency},
  'refund_status': ?refund,
};

void main() {
  test('the demo account totals 67.75 GBP, not 71.90', () {
    final r = buildSpendReport(demoShipments);
    expect(r.spendByCurrency['GBP'], closeTo(67.75, 0.001));
    expect(r.spendLabel('en'), contains('67.75 GBP'));
    expect(r.spendLabel('en'), isNot(contains('71.90')));
  });

  test('a refunded label is neither spend nor a shipment', () {
    final r = buildSpendReport([
      label('a', '5.00', 'GBP', carrier: 'RoyalMailV3'),
      label('b', '4.15', 'GBP', carrier: 'RoyalMailV3', refund: 'refunded'),
    ]);
    expect(r.spendByCurrency, {'GBP': 5.0});
    expect(r.count, 1);
    expect(r.carrierCount['RoyalMailV3'], 1);
    expect(r.carrierSpend['RoyalMailV3'], {'GBP': 5.0});
  });

  test('a pending refund is still spend, and is also shown on its own', () {
    final r = buildSpendReport([
      label('a', '8.40', 'USD'),
      label('b', '9.80', 'USD', refund: 'submitted'),
      label('c', '3.45', 'GBP', refund: 'rejected'),
    ]);
    expect(r.spendByCurrency['USD'], closeTo(18.20, 0.001));
    expect(
      r.spendByCurrency['GBP'],
      closeTo(3.45, 0.001),
      reason: 'a refused refund is ordinary spend',
    );
    expect(r.pendingRefundsByCurrency, {'USD': 9.80});
    expect(r.pendingRefundsLabel('en'), '9.80 USD');
  });

  test('the demo account shows 9.80 USD pending', () {
    expect(
      buildSpendReport(demoShipments).pendingRefundsLabel('en'),
      '9.80 USD',
    );
  });

  test('a shipment with no bought label is not counted', () {
    final r = buildSpendReport([
      {'id': 'quote-only'},
      label('a', '2.00', 'EUR'),
    ]);
    expect(r.count, 1);
  });

  test('currencies are never added together', () {
    final r = buildSpendReport([
      label('a', '10.00', 'USD'),
      label('b', '10.00', 'GBP'),
      label('c', '1.00', 'gbp'),
    ]);
    expect(r.spendByCurrency, {'USD': 10.0, 'GBP': 11.0});
    expect(r.spendLabel('en'), isNot(contains('21')));
  });
}
