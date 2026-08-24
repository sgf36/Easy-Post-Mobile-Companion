# Getting to Play production without twelve Android-owning friends

Written 2026-08-24. The blocker: a personal Play developer account created after
13 November 2023 must run a closed test with **at least twelve testers, opted in
continuously for fourteen days**, before it can apply for production access.
SFields (`5851342681408037291`) is a personal account and is subject to it.

## What actually counts, so nothing is wasted

- Twelve **distinct people**, on **real devices**, with **genuine Google
  accounts**. Emulators, duplicate accounts and bots do not count.
- Each must open the opt-in link, join the test, and install from Play **signed
  in as that account**.
- Fourteen **continuous** days. Someone leaving mid-way resets what they
  contributed, so the count is of testers still opted in, tracked daily.
- They do **not** have to use the app meaningfully. The requirement is opting in
  and staying opted in. Feedback is encouraged, not counted.

## Two things that look like ways round it and are not

**Open testing is not a substitute.** It is the obvious thought — make the test
public, let anyone join. But open testing only becomes available *after*
production access is granted, so it sits on the far side of the same gate.

**Extra Google accounts of your own do not count.** Google matches on distinct
accounts and devices, and enforcement here has been active. The downside is not
a failed test; it is account termination, which would take the desktop product's
companion app with it.

---

## Option A — the organisation account you already have

**This is the highest-leverage option and it contradicts the note in
`project-google-play-account`.**

Organisation accounts are **exempt** from the twelve-tester requirement
entirely. That memory records the organisation route as a dead end for a UK sole
trader, because Google wanted a Certificate of Incorporation and a D-U-N-S
number alone was insufficient.

But an organisation account **exists**, seen in the Console on 2026-08-24:

| | |
|---|---|
| Name | Spencer Fields |
| Type | **Organization account** |
| Account ID | `5069135324388668209` |
| Login | `software_support@spencerfields.com` |
| Apps | none |
| State | *"To publish apps, finish setting up your developer account"* — identity and phone verification outstanding |

So the question is no longer "can one be created" but "**will this one
verify**". That is worth establishing before spending effort on twelve testers,
because if it verifies the requirement disappears rather than being satisfied.

If it does verify, the app moves by **app transfer** — a supported flow, not a
rebuild. Worth knowing before starting:

- Both accounts must be registered and active, with nothing missing.
- You need the **registration transaction ID** for both accounts, from the
  payment confirmation emails or Google Payments history.
- Google's support team replies to transfer requests within two business days.
- Users, ratings, reviews and statistics travel with the app. **Test groups do
  not** — the internal tester list would need rebuilding.

**The honest uncertainty:** whether Google will verify a sole trader as an
organisation. Your earlier attempt suggests not, and nothing found today
contradicts that — Google verifies an organisation against its Dun & Bradstreet
record and the linked payments profile. Finding out costs one attempt at the
verification flow, which is cheap next to the alternative.

## Option B — decide production is not needed yet

Worth asking plainly, because the answer may be no.

The Android app is a companion to a **paid desktop licence**. It is unusable
without pairing, and pairing needs a production Easy-Post licence. So its
audience is not the public — it is your existing customers, and only the ones on
Android.

**Internal testing takes up to 100 testers**, updates automatically through Play,
and is already working. If there are fewer than a hundred Android-owning
customers, internal testing distributes the app to every one of them, today,
with no production access at all.

The costs are real but small: testers are added by email address individually,
the app is not discoverable on Play, and the hundred-tester ceiling is a ceiling.

This is the option that requires no permission from Google and no recruitment.

## Option C — recruit twelve, from the people who actually want it

If production is genuinely wanted, the recruitment problem is smaller than it
looks, because **testers do not need to be people you know**.

**Start with your own customers.** Production licence holders are the app's real
audience. An email to the ones on Android — "the phone companion is in testing,
here is the link" — recruits testers who have a reason to stay opted in for
fourteen days, and gives genuine feedback as a side effect. This is the best
pool by some distance: legitimate, relevant, and no favours owed.

**Then the ordinary networks:** family, Cornell and CCUK contacts, anyone with an
Android phone. A tester needs to tap a link and leave it alone for a fortnight.

**Developer mutual-testing communities** exist for exactly this — developers
joining each other's closed tests. They are real people on real devices, which
is what the rule asks for. Quality varies and some fold quickly, so treat the
count as needing headroom.

**Recruit more than twelve.** Fourteen continuous days means one person leaving
on day ten is expensive. Aim for fifteen to eighteen so attrition does not
restart the clock.

**Use a Google Group as the tester list** rather than pasted email addresses.
People join the group themselves, which removes you from the middle of every
addition and removal.

## What not to do

**Paid "12 testers" services.** They are easy to find and they advertise exactly
this problem. Google has been enforcing against fabricated testing, and the
penalty is account-level. The asymmetry is what matters here: the upside is
saving a few weeks of recruitment, the downside is losing the developer account
that also carries the companion to your paid desktop product. Not worth it.

---

## Recommendation

1. **Establish whether the organisation account can verify.** It already exists;
   the only question is whether Google accepts a sole trader as an organisation.
   If yes, the requirement vanishes and the app transfers. This is one afternoon
   and it is the only route that removes the problem rather than satisfying it.
2. **Meanwhile, ship on internal testing.** It works now, it updates properly,
   and it reaches every Android customer you are likely to have. Nothing about
   this decision blocks it.
3. **Only if production is genuinely needed and the organisation route fails**,
   run the closed test — recruiting from the desktop customer base first, with
   headroom above twelve.

The order matters: (1) and (2) cost little and may make (3) unnecessary.

## Sources

- [App testing requirements for new personal developer accounts](https://support.google.com/googleplay/android-developer/answer/14151465?hl=en)
- [Set up an open, closed, or internal test](https://support.google.com/googleplay/android-developer/answer/9845334?hl=en)
- [Transfer apps between developer accounts](https://support.google.com/googleplay/android-developer/answer/6230247)
- [Required information to create a Play Console developer account](https://support.google.com/googleplay/android-developer/answer/13628312?hl=en)
