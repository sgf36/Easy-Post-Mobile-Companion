# App Store Connect listing — Easy-Post Mobile Companion

Review-ready copy for the iOS App Store listing. House style throughout: no
Oxford commas, no abbreviations in prose (specialist search terms excepted in
the keyword field), no pronouns, refined register. Character ceilings are
Apple's; counts are noted where a field is constrained.

---

## App information (localisation-independent)

| Field | Value |
|---|---|
| **Name** (≤30) | `Easy-Post Mobile Companion` — 26 |
| **Subtitle** (≤30) | `Track, insure and file claims` — 29 |
| **Bundle ID** | `com.spencerfields.easypostmobilecompanion` |
| **Primary category** | Business |
| **Secondary category** | Productivity |
| **Age rating** | 4+ (no restricted content) |
| **Price** | Free (the paid licence lives on Easy-Post Desktop) |
| **Copyright** | `2026 Spencer Fields` |

### URLs

| Field | Value | Status |
|---|---|---|
| **Marketing URL** | `https://easy-post.spencerfields.com/mobile.html` | ⚠ page written, not yet deployed |
| **Support URL** | `https://easy-post.spencerfields.com/mobile.html` | ⚠ same |
| **Privacy Policy URL** | `https://easy-post.spencerfields.com/mobile-privacy.html` | ⚠ **required for submission** — written, not yet deployed |

---

## Promotional text (≤170)

> The Easy-Post shipping console, now on iPhone. Pair once with a QR code, then
> track parcels, buy insurance, file claims and look up tariff codes from
> anywhere.

*(≈158 characters. Editable after release without a new binary.)*

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
• Buy insurance against loss or damage
• File a claim on an insured parcel, with type, value and supporting detail
• Review and cancel scheduled collections
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

## What's New (version 1.0.0 — first release)

First release of the Easy-Post Mobile Companion. Pair with Easy-Post Desktop to
track shipments, buy insurance, file claims, manage collections, read spending
reports and look up tariff codes on the move.

---

## Screenshots — required, not yet captured

Apple requires at least one screenshot for the 6.9-inch iPhone display; a
6.5-inch set is strongly advised for older-device coverage. Android frames are
not accepted, so these must come from the iOS simulator on the Cloud Mac using
`CAPTURE-IOS-SCREENSHOTS.md`.

Recommended set (portrait), captured against the review-code demo device so the
lists are populated:

1. **Tracking** — the colour-coded status list (the flagship screen)
2. **Shipment detail** — scan timeline plus the journey map
3. **Insurance / Buy insurance** — the management action
4. **Claims / File a claim** — the form
5. **Reports** — the per-carrier spending breakdown
6. **HTS Lookup** — an international-post tool

App preview video is optional and out of scope for the first release.

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

## Pre-submission checklist (blockers marked ⚠)

- [ ] ⚠ Deploy `mobile.html` and `mobile-privacy.html` to the live domain (cPanel UAPI)
- [ ] ⚠ Capture the iOS simulator screenshot set on the Cloud Mac
- [ ] Upload the 1024 icon
- [ ] Paste name, subtitle, promotional text, description, keywords
- [ ] Set the three URLs
- [ ] Set categories, age rating, price, copyright
- [ ] Complete the App Privacy questionnaire
- [ ] Attach the build (the TestFlight upload from CI provides it)
- [ ] Localise (mirror the desktop language set) — optional for first submission
- [ ] Final review, then submit for App Review (explicit go-ahead required)
