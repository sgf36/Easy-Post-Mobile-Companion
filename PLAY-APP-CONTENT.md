# Play Console — App content declarations

The answers, and what each one rests on. These are the last thing between the
listing and a first publication; everything else the API could set is set.

Only **Data safety** has an endpoint —
`POST /androidpublisher/v3/applications/{package}/dataSafety`, taking the CSV
that Play Console's own import expects. The rest are Console-only. All of them
are attestations about the product rather than configuration, so the answers
below are worked out from the code and cited, not asserted.

---

## App access — the one that fails a review if it is skipped

**Answer: all functionality is restricted, and credentials must be supplied.**

The app is unusable without pairing. `RootGate` opens on `PairScreen` and no
other screen is reachable, so a reviewer who is handed the binary sees a QR
scanner and nothing else. Play will reject on that alone.

Give the reviewer the same route App Review uses:

| | |
|---|---|
| Instruction | Choose **Enter review code instead** on the pairing screen |
| Code | `epmc-demo-7f3a9c2e` |
| Username / password | none — the code is the whole credential |

That redeems against `POST /pair/demo` on the proxy, which is gated on the
`REVIEW_CODE` and `DEMO_EASYPOST_TEST_KEY` secrets and hands back a test-mode
account. No production data is reachable with it.

---

## Ads

**Answer: no, the app contains no ads.** There is no ad SDK in `pubspec.yaml`
and no advertising identifier is read.

## Content rating

Business/productivity questionnaire, and every content question is **no** —
no violence, sexuality, profanity, drugs, gambling, or user-generated content.
The app shows parcel statuses and tariff codes.

Two that are easy to answer wrongly:

- **Does the app let users interact or exchange content?** No. Nothing is shared
  between users; there is no messaging and no user-generated content.
- **Does the app share the user's location?** No. The journey map plots carrier
  scan locations from the tracking record. The device's own location is never
  read, and there is no location permission in the manifest.

Expected outcome: PEGI 3 / ESRB Everyone / IARC equivalent.

## Target audience and content

**Answer: 18 and over.** Not designed for children, no appeal to children, no
child-directed content. The app requires a paid business licence to do anything.

## Government apps, financial features, health

**No** to all three.

"Financial features" is the one worth pausing on. The app shows what a label
cost and whether a refund was settled, but it moves no money, offers no credit,
handles no payment instrument and has no in-app purchase — the licence is bought
on the desktop side. None of Play's financial-features categories apply.

## Privacy policy

`https://easy-post.spencerfields.com/mobile-privacy.html` — live, and already
set as the App Store privacy policy URL on all 28 localisations.

---

## Data safety — and a discrepancy worth resolving first

**The App Store declaration for this app says no data is collected at all.**
Read against the backend, that looks too strong, and the same reasoning applied
to Play would produce a declaration that is wrong in the same direction.

What the developer's own backend stores, per
`EasyPost-Desktop-App/server/easypost-mobile-proxy/schema.sql`, table `devices`:

| Column | What it is | Play category |
|---|---|---|
| `device_token` | long-lived bearer token identifying the phone | Device or other IDs |
| `push_token` | APNs/FCM registration token | Device or other IDs |
| `license_order`, `license_tier` | the licence purchase this pairing is bound to | arguably Purchase history |
| `platform` | ios / android | Device or other IDs |
| `created_at`, `last_seen` | when it paired, when it last called | App activity |
| `ciphertext`, `iv` | the EasyPost key, encrypted with a key the server does not hold | not readable by the developer |

That is stored, not ephemeral, and it is tied to an identifiable customer
through `license_order`. It is a thin set and none of it is sold or shared, but
"none collected" does not describe it.

**Shipment data is genuinely not collected.** `handleEp` in `worker.js` forwards
the request to EasyPost and returns the response body straight through. Nothing
is written, nothing is logged, and `easypostKey` is nulled immediately after
use. Under Google's rules, data transmitted and processed ephemerally without
being stored is not "collected", so tracking numbers, addresses and parcel
statuses fall outside the declaration.

### Recommended answers

- **Data collected:** Device or other IDs; App activity. Optionally Purchase
  history, if `license_order` is treated as one.
- **Purpose:** App functionality only. Not analytics, not advertising, not
  personalisation.
- **Linked to the user:** yes — `license_order` ties a device to a customer.
- **Used to track the user:** no. Nothing is joined with third-party data and
  nothing leaves the Supplier.
- **Shared with third parties:** no. EasyPost receives the shipment request as
  the service being called, which Google treats as processing on the
  developer's behalf rather than sharing.
- **Encrypted in transit:** yes, HTTPS throughout.
- **Deletion:** yes — unpairing revokes and removes the device row.

### Before submitting either store

The Apple declaration and this one should say the same thing, because the same
backend sits behind both. Either that reasoning is wrong and "none" is right, or
the App Store answers understate what is held and should be revised. Worth
deciding once rather than twice.

### Submitting it by API

`applications.dataSafety` takes the **contents of the CSV** that Play Console's
Data safety section imports, not a JSON body of answers. Export the template
from the Console first — Data safety > Export — so the column set matches the
schema version Google is currently accepting; a hand-authored CSV against a
guessed template either errors or, worse, declares something nobody chose.
