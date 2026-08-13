// Every ARB catalogue must carry exactly the keys app_en.arb carries.
//
// Without this a missing key is invisible until a user sees a raw identifier —
// or, worse, until an App Store screenshot does. It is the Flutter counterpart
// of the desktop app's tests/test_i18n.py, which guards the same property over
// app/resources/locales/*.json.
//
// The second half checks placeholders rather than only key names: a translation
// that drops {date} compiles perfectly and then renders a sentence with a hole
// in it, which key parity alone would never catch.
import 'dart:convert';
import 'dart:io';

import 'package:easypost_mobile_companion/l10n/app_localizations.dart';
import 'package:easypost_mobile_companion/models/tracker.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

/// The App Store listing languages, collapsed to the codes Flutter resolves.
/// en-GB/en-US and pt-BR/pt differ in the store listing, not in the app.
const List<String> expectedLocales = <String>[
  'ar', 'cs', 'de', 'el', 'en', 'es', 'fr', 'he', 'hi', 'hr', 'hu', 'id',
  'it', 'ja', 'ko', 'ms', 'nl', 'pl', 'pt', 'ro', 'ru', 'sv', 'th', 'tr',
  'uk', 'vi', 'zh',
];

final Directory _arbDir = Directory('lib/l10n');

Map<String, String> _messages(String code) {
  final file = File('${_arbDir.path}/app_$code.arb');
  final decoded = jsonDecode(file.readAsStringSync()) as Map<String, dynamic>;
  return <String, String>{
    for (final e in decoded.entries)
      if (!e.key.startsWith('@')) e.key: e.value as String,
  };
}

/// Placeholder names used in an ICU message: "Showing {shown} of {total}".
Set<String> _placeholders(String message) =>
    RegExp(r'\{(\w+)\}').allMatches(message).map((m) => m.group(1)!).toSet();

void main() {
  group('ARB catalogues', () {
    test('one file exists per App Store listing language', () {
      final present = _arbDir
          .listSync()
          .whereType<File>()
          .map((f) => f.uri.pathSegments.last)
          .where((n) => n.startsWith('app_') && n.endsWith('.arb'))
          .map((n) => n.substring(4, n.length - 4))
          .toList()
        ..sort();
      expect(present, expectedLocales,
          reason: 'the app must offer the languages the listing advertises');
    });

    test('the app declares every catalogue as a supported locale', () {
      final supported =
          AppLocalizations.supportedLocales.map((l) => l.languageCode).toList()
            ..sort();
      expect(supported, expectedLocales,
          reason: 'a catalogue Flutter never selects is a file nobody reads');
    });

    test('every locale carries exactly the English keys', () {
      final english = _messages('en');
      final problems = <String, String>{};

      for (final code in expectedLocales) {
        if (code == 'en') continue;
        final keys = _messages(code).keys.toSet();
        final missing = english.keys.toSet().difference(keys);
        final extra = keys.difference(english.keys.toSet());
        if (missing.isNotEmpty || extra.isNotEmpty) {
          problems[code] =
              'missing=${missing.toList()..sort()} extra=${extra.toList()..sort()}';
        }
      }

      expect(problems, isEmpty, reason: 'key mismatches: $problems');
    });

    test('every translation keeps the placeholders its English original has',
        () {
      final english = _messages('en');
      final problems = <String>[];

      for (final code in expectedLocales) {
        if (code == 'en') continue;
        final messages = _messages(code);
        for (final entry in english.entries) {
          final translated = messages[entry.key];
          if (translated == null) continue; // reported by the key-parity test
          final want = _placeholders(entry.value);
          final got = _placeholders(translated);
          if (want.difference(got).isNotEmpty || got.difference(want).isNotEmpty) {
            problems.add('$code/${entry.key}: expected $want, found $got');
          }
        }
      }

      expect(problems, isEmpty, reason: problems.join('\n'));
    });

    test('nothing is left as its English original by accident', () {
      // Not every string can differ — "Status" is "Status" in German — so this
      // only fails a locale that is *entirely* English, which is what an ARB
      // copied as a placeholder and never translated looks like.
      final english = _messages('en');
      for (final code in expectedLocales) {
        if (code == 'en') continue;
        final messages = _messages(code);
        final identical =
            english.entries.where((e) => messages[e.key] == e.value).length;
        expect(identical, lessThan(english.length ~/ 2),
            reason: 'app_$code.arb looks like an untranslated copy of English');
      }
    });
  });

  group('statuses translate, carriers do not', () {
    test('a status is prose and changes with the language', () async {
      final en = await AppLocalizations.delegate.load(const Locale('en'));
      final de = await AppLocalizations.delegate.load(const Locale('de'));
      final ja = await AppLocalizations.delegate.load(const Locale('ja'));

      expect(statusLabel(en, 'in_transit'), 'In transit');
      expect(statusLabel(de, 'in_transit'), isNot('In transit'));
      expect(statusLabel(ja, 'in_transit'), isNot('In transit'));

      // And never the raw code, in any language: `in_transit` on a status badge
      // is exactly what the first App Store capture published.
      for (final t in [en, de, ja]) {
        for (final code in ['in_transit', 'out_for_delivery', 'return_to_sender']) {
          expect(statusLabel(t, code), isNot(contains('_')));
        }
      }
    });

    test('an unknown status reads as words, not as its code', () async {
      final de = await AppLocalizations.delegate.load(const Locale('de'));
      expect(statusLabel(de, 'some_new_state_easypost_invented'), de.statusUnknown);
    });

    test('a carrier is a brand and reads the same everywhere', () {
      // carrierDisplayName takes no localisations at all, which is the point:
      // "Royal Mail V3" is a company's name, not a phrase to be rendered.
      expect(carrierDisplayName('RoyalMailV3'), 'Royal Mail V3');
      expect(carrierDisplayName('DHLExpress'), 'DHL Express');
    });
  });
}
