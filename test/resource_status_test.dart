// Pickups, insurance policies and claims each have their own status vocabulary.
//
// 1.3.0 ran all three through the tracker vocabulary, so every one of them read
// "Unknown" — including a scheduled pickup shown beside its own Cancel button.
// The values below are EasyPost's documented enums for each object, not the
// fixtures' guesses.
import 'package:easypost_mobile_companion/l10n/app_localizations.dart';
import 'package:easypost_mobile_companion/models/tracker.dart';
import 'package:easypost_mobile_companion/services/demo_fixtures.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

/// docs.easypost.com: Pickup object `status`.
const pickupStatuses = ['scheduled', 'canceled'];

/// docs.easypost.com: Insurance object `status`.
const insuranceStatuses = [
  'new',
  'pending',
  'purchased',
  'failed',
  'cancelled',
];

/// docs.easypost.com: Claim object `status`.
const claimStatuses = [
  'submitted',
  'in_review',
  'approved',
  'approved_partial',
  'rejected',
  'cancelled',
  'needs_action',
];

void main() {
  late List<AppLocalizations> locales;

  setUpAll(() async {
    locales = [
      for (final l in AppLocalizations.supportedLocales)
        await AppLocalizations.delegate.load(l),
    ];
  });

  void expectAllNamed(
    String what,
    List<String> statuses,
    String Function(AppLocalizations, Object?) text,
  ) {
    for (final t in locales) {
      final labels = <String>{};
      for (final s in statuses) {
        final label = text(t, s);
        expect(
          label,
          isNot(t.statusUnknown),
          reason: '$what "$s" reads "Unknown" in ${t.localeName}',
        );
        expect(
          label,
          isNot(contains('_')),
          reason: '$what "$s" leaks its code in ${t.localeName}',
        );
        labels.add(label);
      }
      expect(
        labels,
        hasLength(statuses.length),
        reason: 'two $what statuses share one label in ${t.localeName}',
      );
    }
  }

  test('every documented pickup status has words, in every language', () {
    expectAllNamed('pickup', pickupStatuses, pickupStatusText);
  });

  test('every documented insurance status has words, in every language', () {
    expectAllNamed('insurance', insuranceStatuses, insuranceStatusText);
  });

  test('every documented claim status has words, in every language', () {
    expectAllNamed('claim', claimStatuses, claimStatusText);
  });

  test(
    'the statuses in the screenshot fixtures never read "Unknown"',
    () async {
      final en = await AppLocalizations.delegate.load(const Locale('en'));
      for (final p in demoPickups) {
        expect(pickupStatusText(en, p['status']), isNot(en.statusUnknown));
      }
      for (final i in demoInsurances) {
        expect(insuranceStatusText(en, i['status']), isNot(en.statusUnknown));
      }
      for (final c in demoClaims) {
        expect(claimStatusText(en, c['status']), isNot(en.statusUnknown));
      }
    },
  );

  test('English reads as prose and German is translated', () async {
    final en = await AppLocalizations.delegate.load(const Locale('en'));
    final de = await AppLocalizations.delegate.load(const Locale('de'));
    expect(pickupStatusText(en, 'scheduled'), 'Scheduled');
    expect(pickupStatusText(en, 'canceled'), 'Cancelled');
    expect(insuranceStatusText(en, 'purchased'), 'Purchased');
    expect(claimStatusText(en, 'approved_partial'), 'Partly approved');
    expect(claimStatusText(de, 'submitted'), isNot('Submitted'));
  });

  test(
    'absent stays absent; an unrecognised value still reads as words',
    () async {
      final en = await AppLocalizations.delegate.load(const Locale('en'));
      for (final text in [
        pickupStatusText,
        insuranceStatusText,
        claimStatusText,
      ]) {
        expect(text(en, null), '');
        expect(text(en, '  '), '');
        expect(text(en, 'something_new'), en.statusUnknown);
      }
      // `unknown` is itself a documented pickup status.
      expect(pickupStatusText(en, 'unknown'), en.statusUnknown);
    },
  );

  test('the fee is read from inside the Fee object', () {
    expect(
      insuranceFeeAmount({
        'fee': {'object': 'Fee', 'type': 'InsuranceFee', 'amount': '0.50000'},
      }),
      '0.50000',
    );
    expect(insuranceFeeAmount({'fee': '1.25'}), '1.25');
    expect(insuranceFeeAmount(const {}), isNull);
  });
}
