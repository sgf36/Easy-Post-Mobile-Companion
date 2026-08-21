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
  'whatsNew': 4000,
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

    test('whatsNew is present in every locale', () {
      // This file used to forbid the field. App Store Connect rejects it on an
      // initial release — 409 STATE_ERROR, "Attribute 'whatsNew' cannot be
      // edited at this time" — and every record this had fed until 1.1.0 was
      // one. An update is the opposite case: Apple requires a release note,
      // and a locale without one blocks the whole submission rather than just
      // that language.
      //
      // So if a first release is ever fed from this file again, the field has
      // to come back out. It does not belong to the version being submitted
      // today.
      _metadata().forEach((locale, value) {
        final text = (value as Map<String, dynamic>)['whatsNew'] as String;
        expect(text.trim(), isNotEmpty, reason: locale);
      });
    });

    test('the copy claims only what the app does', () {
      // The companion tracks, shows detail and a journey map, lists history,
      // insurance, claims, pickups and refund requests, and looks up HTS
      // codes. Buying a label is the desktop app's job, and a listing that
      // says otherwise is a rejection or a refund request.
      //
      // Buying insurance and filing a claim were removed in 1.0.1 under App
      // Review guideline 5.1.1(ix). Asking for a refund is the same shape of
      // action and is likewise not offered — this app only says where an
      // existing request has got to.
      //
      // English only, and therefore a partial guard: a phrase list cannot
      // police 28 languages. It catches the case that actually happened, which
      // is copy edited in English and then left behind by the binary.
      const labelPhrases = <String>[
        'buy a label',
        'buy labels',
        'purchase a label',
        'print a label',
        'print labels',
      ];
      const removedActionPhrases = <String>[
        'buy insurance',
        'purchase insurance',
        'file a claim',
        'file claims',
        'request a refund',
        'request refunds',
      ];

      // Not the subtitle. "Track, insure and file claims" would fail this and
      // is nonetheless what is live and Apple-approved on 1.0.1 — the app
      // still shows insurance policies and claims, it just no longer creates
      // them. Rewriting it means finding a replacement under 30 characters in
      // 28 languages, which is a decision about the listing rather than a
      // correction to it, so it is deliberately left open rather than
      // quietly failed here.
      for (final locale in <String>['en-GB', 'en-US']) {
        final fields = _metadata()[locale] as Map<String, dynamic>;
        for (final field in <String>['description', 'promotionalText']) {
          final text = (fields[field] as String).toLowerCase();
          for (final phrase in [...labelPhrases, ...removedActionPhrases]) {
            expect(text, isNot(contains(phrase)), reason: '$locale.$field: $phrase');
          }
        }
      }

      // The label phrases are worth checking everywhere, since "label" is
      // borrowed unchanged into several of the listing languages.
      _metadata().forEach((locale, value) {
        final description =
            ((value as Map<String, dynamic>)['description'] as String).toLowerCase();
        for (final phrase in labelPhrases) {
          expect(description, isNot(contains(phrase)), reason: '$locale: $phrase');
        }
      });
    });

    test('every locale describes the same set of sections', () {
      // The drift this catches is real: the insurance and claim forms were cut
      // from the app in 1.0.1 and from the live listing at the same time, but
      // not from this file, which kept advertising both until 1.1.0. One
      // locale edited and twenty-seven forgotten is the same failure with a
      // smaller blast radius, and a bullet count sees both without needing to
      // read 28 languages.
      //
      // The "manage" paragraph is the third: intro, tracking, manage, tools,
      // languages, privacy, requirement.
      _metadata().forEach((locale, value) {
        final paragraphs =
            ((value as Map<String, dynamic>)['description'] as String).split('\n\n');
        expect(paragraphs.length, 7, reason: locale);
        final manage = paragraphs[2].split('\n');
        expect(manage.length, 4, reason: '$locale: heading plus three bullets');
        expect(manage.skip(1).every((l) => l.startsWith('•')), isTrue,
            reason: locale);
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
