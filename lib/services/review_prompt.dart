import 'package:flutter/foundation.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'proxy_client.dart';

/// Asking for a rating, adapted to an app that sells nothing.
///
/// Both listings show zero ratings, and a zero-rated listing is penalised
/// twice: the count feeds store search ranking, and it is the first thing a
/// visitor's eye lands on. Nothing in this app has ever asked.
///
/// **The desktop trigger does not transfer, and pretending otherwise would be
/// the bug.** `REVIEW-PROMPT-BRIEF.md` fires the desktop prompt on a label
/// rendering successfully — the moment money turned into a thing the user
/// wanted. This app has no such moment. Every screen here reads: trackers,
/// refunds, claims, insurance, reports. The single mutation in the whole
/// application is cancelling a pickup, which is a disappointment, not a
/// success. Hooking the ask to "an operation succeeded" would either never
/// fire or fire on a cancellation.
///
/// So the success this measures is **repeat deliberate use**: the user opened
/// the app and it showed them their real shipments, on three separate days.
/// That is the honest analogue of three shipments — it cannot be reached by
/// accident, and it means the app has been chosen again after the novelty.
///
/// Four rules, each because the obvious implementation gets it wrong:
///
/// 1. **Days, not loads.** A pull-to-refresh loop would otherwise earn a
///    prompt in thirty seconds. Only the first successful load of each
///    calendar day counts, so the counter measures returning, not scrolling.
///
/// 2. **Never on the day it was earned.** [recordSuccess] only arms; the ask
///    comes on a later day. A dialog thrown over a list the user just pulled
///    to refresh interrupts the thing they opened the app to do.
///
///    This is enforced *here*, on a stored day, rather than by being careful
///    about where [maybeAsk] is called. Relying on the call site meant relying
///    on `resumed` firing, which does not happen on a cold launch — so the
///    prompt would only ever have reached users who background the app and
///    come back, and the rule would have been silently doing nothing for
///    everyone else.
///
/// 3. **Never after friction.** A failed load, an expired pairing or a proxy
///    error stands the prompt down for the rest of the session. Asking on the
///    heels of an error collects the error.
///
/// 4. **Never in a build that is not a real user.** Screenshot builds
///    (`DEMO_FIXTURES=true`) drive dozens of loads and must never prompt.
///
/// App Review is covered by the gates rather than by a special case: a
/// reviewer redeeming a demo code would need to come back on three separate
/// days, a week apart, before anything could appear. There is deliberately no
/// provenance flag on [PairingCredentials] for this — adding one would change
/// the stored credential schema to defend against something the calendar
/// already prevents.
///
/// Apple caps the system prompt at three appearances a year per device and
/// silently ignores the rest, so the count kept here is about not wasting
/// those three. Neither platform reports whether the prompt was shown or what
/// was said, so `tools/ratings_watch.py` on the store side is the only
/// measurement — see [maybeAsk].
abstract class ReviewPrompt {
  /// The app showed the user their real data. Arms the ask; shows nothing.
  Future<void> recordSuccess();

  /// Something failed. Stands the ask down for the rest of this session.
  void noteFriction();

  /// Called when the app returns to the foreground. Shows the system prompt if
  /// this device has earned one and has not been asked recently.
  Future<void> maybeAsk();
}

class StoreReviewPrompt implements ReviewPrompt {
  /// The clock, injectable so the calendar gates can be tested.
  ///
  /// Every gate here is measured in days, which means the only way to test any
  /// of them against the real clock is to wait a week. A test that cannot
  /// advance time can only ever assert the first branch, which is the branch
  /// that was never in doubt.
  final DateTime Function() _now;

  StoreReviewPrompt({DateTime Function()? clock})
      : _now = clock ?? DateTime.now;

  static const _days = 'review-active-days';
  static const _lastDay = 'review-last-counted-day';
  static const _firstDay = 'review-first-day';
  static const _armed = 'review-armed';
  static const _armedDay = 'review-armed-day';
  static const _lastAsked = 'review-last-asked-ms';
  static const _askCount = 'review-ask-count';

  /// Separate days of real use before the first ask. Three, not one — a single
  /// visit is a trial, and rating a trial rates the curiosity.
  static const _minDays = 3;

  /// Days between first use and the earliest possible ask, so a burst of
  /// three days in one week cannot short-circuit the intent of [_minDays].
  static const _settleDays = 7;

  /// A quiet period of our own, well inside Apple's. Someone who checks a
  /// parcel every morning should not meet this prompt twice.
  static const _quietDays = 120;

  /// Deliberately below Apple's own ceiling of three per 365 days.
  static const _maxAsks = 3;

  /// Set for the life of the process, never persisted. Friction should cost
  /// the session it happened in, not the install.
  bool _friction = false;

  /// Days since the epoch in local time. The unit the gates are written in:
  /// "came back on another day" is a calendar fact, not an elapsed-hours one,
  /// so someone checking at 23:50 and again at 00:10 has come back.
  int _today() {
    final n = _now();
    return DateTime(n.year, n.month, n.day).millisecondsSinceEpoch ~/ 86400000;
  }

  @override
  void noteFriction() => _friction = true;

  @override
  Future<void> recordSuccess() async {
    if (ProxyClient.useFixtures) return;
    final prefs = await SharedPreferences.getInstance();
    final today = _today();

    // Stamp the first day here rather than at launch. A user who installs and
    // never pairs has not started a clock, and back-filling from install would
    // let the settle period elapse on an app that was never used.
    if (prefs.getInt(_firstDay) == null) await prefs.setInt(_firstDay, today);

    if (prefs.getInt(_lastDay) == today) return; // rule 1: once per day
    await prefs.setInt(_lastDay, today);
    final days = (prefs.getInt(_days) ?? 0) + 1;
    await prefs.setInt(_days, days);

    if (days < _minDays) return;
    if (today - (prefs.getInt(_firstDay) ?? today) < _settleDays) return;

    // Only stamp the day on the transition into armed. Re-stamping on every
    // later success would push the "not today" guard forward each time the app
    // was opened, and the ask would never arrive.
    if (prefs.getBool(_armed) ?? false) return;
    await prefs.setBool(_armed, true);
    await prefs.setInt(_armedDay, today);
  }

  @override
  Future<void> maybeAsk() async {
    if (_friction || ProxyClient.useFixtures) return;

    final prefs = await SharedPreferences.getInstance();
    if (!(prefs.getBool(_armed) ?? false)) return;
    if (prefs.getInt(_armedDay) == _today()) return; // rule 2

    if ((prefs.getInt(_askCount) ?? 0) >= _maxAsks) {
      await prefs.setBool(_armed, false);
      return;
    }

    final last = prefs.getInt(_lastAsked) ?? 0;
    final since = _now().millisecondsSinceEpoch - last;
    if (last != 0 && since < _quietDays * 86400 * 1000) {
      // Still quiet. Disarm rather than leave it pending, or the ask lands the
      // instant the period ends, months after the use that earned it and
      // attached to nothing the user just did.
      await prefs.setBool(_armed, false);
      return;
    }

    // Disarmed before the prompt, not after. The platform call can take a
    // moment and the user may background the app during it; leaving it armed
    // would ask again on the next resume.
    await prefs.setBool(_armed, false);

    // A store that cannot be asked must not spend the budget. If this returns
    // false — no Play Store on the device, a sideloaded build, a simulator —
    // the ask never happened, so neither the timestamp nor the count moves.
    if (!await askOs()) return;

    await prefs.setInt(_lastAsked, _now().millisecondsSinceEpoch);
    await prefs.setInt(_askCount, (prefs.getInt(_askCount) ?? 0) + 1);
  }

  /// Show the platform's own prompt; true if it was actually asked for.
  ///
  /// The single seam between the gates and the plugin, so the gates can be
  /// tested without a method channel. Everything above this line is arithmetic
  /// on stored numbers and is worth testing; this line is not.
  @protected
  @visibleForTesting
  Future<bool> askOs() async {
    final review = InAppReview.instance;
    if (!await review.isAvailable()) return false;
    await review.requestReview();
    return true;
  }
}

/// Records what it was asked to do, and shows nothing. For tests, and for any
/// platform where the system prompt does not exist.
@visibleForTesting
class FakeReviewPrompt implements ReviewPrompt {
  int successes = 0;
  int asks = 0;
  bool friction = false;

  @override
  Future<void> recordSuccess() async => successes++;

  @override
  void noteFriction() => friction = true;

  @override
  Future<void> maybeAsk() async => asks++;
}
