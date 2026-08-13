// store/asc-metadata.json is fed straight to the App Store Connect API by
// whoever submits the app, so a field one character over Apple's limit is not a
// typo — it is a 409 in the middle of a submission, in whichever of 28 locales
// happens to be too long. German subtitles are the usual casualty: 30
// characters is generous in English and tight in German.
//
// Running this as a test rather than as a one-off script means the limits are
// re-checked on every push, including by whoever edits the copy next.
import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// The App Store listing languages, in Apple's own locale codes.
const List<String> ascLocales = <String>[
  'ar-SA', 'cs', 'de-DE', 'el', 'en-GB', 'en-US', 'es-ES', 'fr-FR', 'he', 'hi',
  'hr', 'hu', 'id', 'it', 'ja', 'ko', 'ms', 'nl-NL', 'pl', 'pt-BR', 'ro', 'ru',
  'sv', 'th', 'tr', 'uk', 'vi', 'zh-Hans',
];

/// Apple's maximum lengths, in characters.
const Map<String, int> limits = <String, int>{
  'description': 4000,
  'keywords': 100,
  'promotionalText': 170,
  'subtitle': 30,
};

Map<String, dynamic> _metadata() =>
    jsonDecode(File('store/asc-metadata.json').readAsStringSync())
        as Map<String, dynamic>;

void main() {
  group('App Store metadata', () {
    test('covers every listing locale, and only those', () {
      final locales = _metadata().keys.toList()..sort();
      expect(locales, ascLocales.toList()..sort());
    });

    test('every field is inside its Apple limit', () {
      final over = <String>[];
      _metadata().forEach((locale, value) {
        final fields = value as Map<String, dynamic>;
        expect(fields.keys.toSet(), limits.keys.toSet(), reason: locale);
        limits.forEach((field, cap) {
          final text = fields[field] as String;
          expect(text.trim(), isNotEmpty, reason: '$locale.$field is blank');
          if (text.length > cap) {
            over.add('$locale.$field: ${text.length} > $cap');
          }
        });
      });
      expect(over, isEmpty, reason: over.join('\n'));
    });

    test('keywords waste no characters on spaces', () {
      // Apple counts the separators. "a, b" spends a character on the space
      // that "a,b" spends on a keyword.
      _metadata().forEach((locale, value) {
        final keywords = (value as Map<String, dynamic>)['keywords'] as String;
        expect(keywords, isNot(contains(', ')), reason: locale);
        expect(keywords, isNot(contains(',,')), reason: locale);
        expect(keywords.trim(), keywords, reason: locale);
      });
    });

    test('no whatsNew field is present', () {
      // Every version record here is an initial release, and App Store Connect
      // rejects the attribute outright on one: 409 STATE_ERROR, "Attribute
      // 'whatsNew' cannot be edited at this time".
      _metadata().forEach((locale, value) {
        expect((value as Map<String, dynamic>).containsKey('whatsNew'), isFalse,
            reason: locale);
      });
    });

    test('the copy claims only what the app does', () {
      // The companion tracks, shows detail and a journey map, lists history,
      // insurance, claims and pickups, and looks up HTS codes. Buying a label
      // is the desktop app's job, and a listing that says otherwise is a
      // rejection or a refund request.
      const forbidden = <String>[
        'buy a label',
        'buy labels',
        'purchase a label',
        'print a label',
        'print labels',
      ];
      _metadata().forEach((locale, value) {
        final description =
            ((value as Map<String, dynamic>)['description'] as String).toLowerCase();
        for (final phrase in forbidden) {
          expect(description, isNot(contains(phrase)), reason: '$locale: $phrase');
        }
      });
    });

    test('every locale names the same number of interface languages', () {
      // The app ships 27 ARB catalogues. If a catalogue is ever added or
      // removed, the listing text saying "27 languages" becomes a false claim
      // in 28 places at once, and this is what notices.
      final arbCount = Directory('lib/l10n')
          .listSync()
          .whereType<File>()
          .where((f) => f.path.endsWith('.arb'))
          .length;
      expect(arbCount, 27);
      _metadata().forEach((locale, value) {
        final description = (value as Map<String, dynamic>)['description'] as String;
        expect(description, contains('27'),
            reason: '$locale does not state the interface language count');
      });
    });
  });
}
