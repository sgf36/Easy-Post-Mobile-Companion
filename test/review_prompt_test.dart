import 'package:easypost_mobile_companion/services/review_prompt.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// A prompt with a clock you can wind and a plugin you never reach.
///
/// Everything worth testing here is a decision about dates, so the tests drive
/// the calendar directly. Against the real clock the only reachable assertion
/// is "the first day does not ask", which was never the risk.
class _Probe extends StoreReviewPrompt {
  _Probe(int day) : super(clock: () => _epoch.add(Duration(days: day)));

  static final DateTime _epoch = DateTime(2026, 1, 1);
  int asks = 0;

  /// Whether the platform would show the prompt. False stands in for a device
  /// with no store — a simulator, or a sideloaded build.
  bool available = true;

  @override
  Future<bool> askOs() async {
    if (!available) return false;
    asks++;
    return true;
  }
}

/// One [_Probe] whose clock moves, since a real install is one device over
/// months rather than a fresh object per day.
class _Device {
  late _Probe prompt;
  int day = 0;

  _Device() {
    prompt = _Probe(0);
  }

  /// Move to a given day. Preserves the ask count and the availability flag,
  /// because they belong to the device, not to the day.
  void goTo(int d) {
    final asks = prompt.asks;
    final available = prompt.available;
    day = d;
    prompt = _Probe(d)
      ..asks = asks
      ..available = available;
  }

  /// A visit: the tracker list loaded, and the ask was offered its chance.
  /// Both happen in every real session, and the module — not this ordering —
  /// is what stops the ask landing on the day it was earned.
  Future<void> visit({bool friction = false}) async {
    if (friction) {
      prompt.noteFriction();
    } else {
      await prompt.recordSuccess();
    }
    await prompt.maybeAsk();
  }
}

void main() {
  setUp(() => SharedPreferences.setMockInitialValues({}));

  test('never asks on the first visit', () async {
    final d = _Device();
    await d.visit();
    expect(d.prompt.asks, 0);
  });

  test('a refresh loop in one day cannot earn a prompt', () async {
    final d = _Device();
    // Twenty successful loads, all on day zero. Only one day is banked, so the
    // three-day gate is nowhere near met.
    for (var i = 0; i < 20; i++) {
      await d.prompt.recordSuccess();
      await d.prompt.maybeAsk();
    }
    expect(d.prompt.asks, 0);
  });

  test('three days inside one week is still too early', () async {
    final d = _Device();
    for (final day in [0, 1, 2, 3]) {
      d.goTo(day);
      await d.visit();
    }
    // The day count is met from day two, but the settle period is not.
    expect(d.prompt.asks, 0);
  });

  test('two days spread over a fortnight is still not enough', () async {
    // Isolates the day count from the settle period. Every other test here has
    // the seven days as the binding constraint, so lowering _minDays to 1 left
    // them all green — this is the one that notices.
    final d = _Device();
    for (final day in [0, 10]) {
      d.goTo(day);
      await d.visit();
    }
    d.goTo(11);
    await d.prompt.maybeAsk();
    expect(d.prompt.asks, 0, reason: 'two days of use is not three');
  });

  test('asks once three days and a week have both passed', () async {
    final d = _Device();
    for (final day in [0, 1, 8]) {
      d.goTo(day);
      await d.visit();
    }
    // Day 8 arms it. Nothing is shown on the visit that earned it; the ask
    // comes on the next resume.
    expect(d.prompt.asks, 0, reason: 'armed, not spent, on the earning visit');

    d.goTo(9);
    await d.prompt.maybeAsk();
    expect(d.prompt.asks, 1);
  });

  test('does not ask again the next day', () async {
    final d = _Device();
    for (final day in [0, 1, 8]) {
      d.goTo(day);
      await d.visit();
    }
    d.goTo(9);
    await d.prompt.maybeAsk();
    expect(d.prompt.asks, 1);

    for (final day in [10, 11, 12, 20, 60]) {
      d.goTo(day);
      await d.visit();
    }
    expect(d.prompt.asks, 1, reason: 'inside the 120-day quiet period');
  });

  test('asks a second time once the quiet period has elapsed', () async {
    final d = _Device();
    for (final day in [0, 1, 8]) {
      d.goTo(day);
      await d.visit();
    }
    d.goTo(9);
    await d.prompt.maybeAsk();

    for (final day in [200, 201, 202]) {
      d.goTo(day);
      await d.visit();
    }
    d.goTo(203);
    await d.prompt.maybeAsk();
    expect(d.prompt.asks, 2);
  });

  test('stops at three asks for the life of the install', () async {
    final d = _Device();
    var day = 0;
    // Ten widely spaced bursts of use. Each one clears the quiet period.
    for (var burst = 0; burst < 10; burst++) {
      for (var i = 0; i < 3; i++) {
        d.goTo(day++);
        await d.visit();
      }
      d.goTo(day++);
      await d.prompt.maybeAsk();
      day += 130;
    }
    expect(d.prompt.asks, 3, reason: 'Apple ignores more; do not spend them');
  });

  test('friction in a session suppresses an otherwise earned ask', () async {
    final d = _Device();
    for (final day in [0, 1, 8]) {
      d.goTo(day);
      await d.visit();
    }
    d.goTo(9);
    d.prompt.noteFriction(); // a failed load earlier in this session
    await d.prompt.maybeAsk();
    expect(d.prompt.asks, 0);
  });

  test('friction costs the session, not the install', () async {
    final d = _Device();
    for (final day in [0, 1, 8]) {
      d.goTo(day);
      await d.visit();
    }
    d.goTo(9);
    d.prompt.noteFriction();
    await d.prompt.maybeAsk();
    expect(d.prompt.asks, 0);

    // Next launch: a new process, so the flag is gone. The arming survived.
    d.goTo(9);
    await d.prompt.maybeAsk();
    expect(d.prompt.asks, 1);
  });

  test('a device with no store spends neither the count nor the quiet period',
      () async {
    final d = _Device();
    d.prompt.available = false;
    for (final day in [0, 1, 8]) {
      d.goTo(day);
      await d.visit();
    }
    d.goTo(9);
    await d.prompt.maybeAsk();
    expect(d.prompt.asks, 0);

    // The same install, later, on a device that can ask. One transient failure
    // must not cost four months of the only lever there is.
    d.prompt.available = true;
    for (final day in [10, 11, 12]) {
      d.goTo(day);
      await d.visit();
    }
    d.goTo(13);
    await d.prompt.maybeAsk();
    expect(d.prompt.asks, 1);
  });

  test('the fake records without showing anything', () async {
    final f = FakeReviewPrompt();
    await f.recordSuccess();
    f.noteFriction();
    await f.maybeAsk();
    expect(f.successes, 1);
    expect(f.asks, 1);
    expect(f.friction, isTrue);
  });
}
