# App Store Connect listing — Easy-Post Mobile Companion

Review-ready copy for the iOS App Store listing. House style throughout: no
Oxford commas, no abbreviations in prose (specialist search terms excepted in
the keyword field), no pronouns, refined register. Character ceilings are
Apple's; counts are noted where a field is constrained.

> **`store/asc-metadata.json` is the source of truth** for description,
> keywords, promotional text, release notes and subtitle, in all 28 listing
> languages, and it is what is fed to the API. It is checked on every push by
> `test/asc_metadata_test.dart`. This file is the English draft and the notes
> around it — the fields below are kept in step by hand, so where the two
> disagree, the JSON is what shipped.

---

## App information (localisation-independent)

| Field | Value |
|---|---|
| **Name** (≤30) | `Easy-Post Mobile Companion` — 26 |
| **Subtitle** (≤30) | `Track, insure and file claims` — 29 · **open question**, see below |
| **Bundle ID** | `com.spencerfields.easypostmobilecompanion` |
| **Primary category** | Business |
| **Secondary category** | Productivity |
| **Age rating** | 4+ (no restricted content) |
| **Price** | Free (the paid licence lives on Easy-Post Desktop) |
| **Copyright** | `2026 Spencer Fields` |

> **The subtitle still names two things the app no longer does.** Buying
> insurance and filing a claim were removed in 1.0.1; the app lists existing
> policies and claims but creates neither. Apple approved the subtitle as it
> stands, and the description and promotional text were corrected around it, so
> this is a listing decision rather than an outstanding error — but replacing it
> means finding something under 30 characters in 28 languages, and German
> already sits at 26 and Hungarian at 29. Left as it is until that is decided;
> `test/asc_metadata_test.dart` deliberately exempts the subtitle from the
> phrase check that would otherwise fail on it.

### URLs

| Field | Value | Status |
|---|---|---|
| **Marketing URL** | `https://easy-post.spencerfields.com/mobile.html` | live, set on the version |
| **Support URL** | `https://easy-post.spencerfields.com/mobile.html` | live, set on the version |
| **Privacy Policy URL** | `https://easy-post.spencerfields.com/mobile-privacy.html` | live, set on every `appInfoLocalization` — a submission blocker if it is ever missing from one |

---

## Promotional text (≤170)

> The Easy-Post shipping console, now on iPhone. Pair once with a QR code, then
> track parcels, follow refund requests and look up tariff codes from anywhere.

*(155 characters. Editable after release without a new binary.)*

---

## Keywords (≤100, comma-separated, no spaces)

```
parcel,shipment,tracking,courier,logistics,delivery,insurance,claims,customs,HTS,label,postage
```

*(94 characters. Carrier trademarks and the parent brand name are deliberately
omitted — Apple rejects third-party trademarks in the keyword field. The words
already in the name and subtitle are not repeated, as Apple indexes those
separately.)*

---

## Description (≤4000)

Easy-Post Mobile Companion brings the Easy-Post shipping console to iPhone. It
pairs with a licensed Easy-Post Desktop installation through a single scan of a
QR code, then mirrors the desktop workflow on the move — with no keys to type
and nothing held in the clear.

TRACK EVERY SHIPMENT
Follow live carrier progress across every parcel in one list, sorted or
filtered on demand, colour-coded by carrier, with an unmistakable icon for each
delivery status. Open any shipment for the full scan history and a map of the
journey from origin to latest location.

MANAGE ON THE MOVE
• Review and cancel scheduled collections
• Follow every refund request from submitted through to refunded or rejected
• Browse the full shipment history at a glance

TOOLS FOR INTERNATIONAL POST
• Look up Harmonized Tariff Schedule codes from the United States International
Trade Commission, ready to paste into a customs declaration
• Read a clear spending report broken down by carrier

BUILT FOR PRIVACY
The production key never leaves the paired desktop in readable form. The
companion holds only an encrypted device credential, and every request travels
through a zero-custody relay that decrypts nothing it stores. Unpairing revokes
the phone's access at any moment.

REQUIRES EASY-POST DESKTOP
A paid, activated Easy-Post Desktop licence is required to pair. Easy-Post
Desktop is available for Windows and macOS from easy-post.spencerfields.com.

---

## What's New (version 1.1.0)

This update adds a Refunds section. Every shipment with a refund request on it
is gathered in one place — still waiting, refused or settled — with the parcel's
own status, carrier, service and label cost beside it. Requesting a refund
remains a desktop task; the companion reports on requests already made.

Translated into all 28 listing languages in `store/asc-metadata.json` under
`whatsNew`. Apple requires the field on an update and rejects it on a first
release, so it belongs to this version rather than to the file in general.

---

## Screenshots

Captured by CI, not by hand: the `Build` workflow's `screenshots` job boots a
6.9-inch simulator on a hosted macOS runner and drives
`integration_test/screenshots_test.dart` against the demo fixtures. One leg per
language, seven languages localised (`en de es fr hi ja zh`), the remaining
twenty-one falling back to English. Sources live in `store/asc-shots-<lang>/`.
`CAPTURE-IOS-SCREENSHOTS.md` covers the local route and the shot list.

The set (portrait, 1320×2868):

1. **Tracking** — the colour-coded status list (the flagship screen)
2. **Shipment detail** — scan timeline plus the journey map
3. **Insurance** — the policies already on the account
4. **Claims** — claims raised on the account and their status
5. **Reports** — the per-carrier spending breakdown
6. **HTS Lookup** — an international-post tool
7. **Refunds** — one row in each state: waiting, refused, settled

3 and 4 are lists rather than forms, because the forms were removed in 1.0.1
under guideline 5.1.1(ix). App preview video remains out of scope.

---

## App icon

`1024×1024` App Store icon already generated at
`scratchpad/asc/AppStoreIcon-1024.png` (alpha flattened on white, as Apple
requires). Matches the desktop app mark.

---

## App Privacy questionnaire (Data collection)

The companion collects no analytics and no advertising identifiers. For the
"App Privacy" nutrition label, the honest answers are:

- **Data used to track you:** none
- **Data linked to you:** none
- **Data not linked to you:** none

The one nuance to declare accurately: shipment data is fetched on demand through
the relay and shown in the app; it is not collected, stored off-device or shared
by the developer. If Apple's flow insists on a category, "Purchases" and
"Other Usage Data" are *not* persisted by the developer, so they remain
unchecked. The privacy policy URL above carries the full statement.

---

## Release checklist

Everything below the rule was done for 1.0 and 1.0.1 and does not recur. What a
release actually costs is the short list first.

Per release:

- [ ] Bump the marketing version in `pubspec.yaml` — Apple closes a pre-release
      train once its version ships, so the build number alone is not enough
- [ ] Write `whatsNew` in all 28 locales in `store/asc-metadata.json`
- [ ] Recapture screenshots if a new screen belongs on the listing, and refresh
      `store/asc-shots-<lang>/`
- [ ] Merge to `main`, which builds and uploads to TestFlight
- [ ] Create the version record, push the metadata, attach the build
- [ ] Final review, then submit for App Review (explicit go-ahead required)

---

Settled, and carried forward automatically:

- [x] `mobile.html` and `mobile-privacy.html` deployed to the live domain
- [x] 1024 icon uploaded
- [x] Name, subtitle, promotional text, description, keywords
- [x] Marketing, support and privacy policy URLs
- [x] Categories, age rating, price, copyright
- [x] App Privacy questionnaire
- [x] Localised into all 28 listing languages
