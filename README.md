# Easy-Post Mobile Companion

Companion phone app (iOS + Android) for [Easy-Post Desktop](https://github.com/sgf36/EasyPost).
Track and manage EasyPost shipments from a phone. Built with Flutter.

## How it works

The desktop app (production, licensed) shows a **pairing QR**. This app scans it,
claims a one-time token from the **easypost-mobile-proxy** backend, and receives
a device token plus a key-encryption key (KEK) that it stores in the phone's
secure enclave. The phone **never holds the raw EasyPost key** — every request
goes through the proxy, which decrypts in memory for one call and enforces a
read/manage-only scope (no label buying). See the desktop repo's
`MOBILE-COMPANION-BUILD-BRIEF.md` and `server/easypost-mobile-proxy`.

Reviewers who have no licensed desktop can pair with a **review code** instead
(`Enter review code` on the pairing screen), which connects to a demo test-mode
account.

## Sections

- **Tracking** — live trackers, detail and journey map
- **History** — every shipment bought, with its rate
- **Insurance**, **Claims**, **Pickups** — what the desktop has raised
- **Refunds** — how far each refund request on a bought label has got:
  submitted, refunded or rejected
- **Reports** — spend by carrier
- **HTS Lookup** — tariff codes

Read-only since 1.0.1. Buying insurance and filing claims were removed after
App Review rejected 1.0 under guideline 5.1.1(ix), and asking for a refund is
the desktop's job for the same reason buying a label is — this shows the answer
that comes back, which is the part somebody has to keep checking.

The Refunds list is derived from the shipments collection, where
`refund_status` lives. EasyPost's `/refunds` endpoint holds a different object,
created by `POST /refunds`, which nothing in this product calls — a tab built
on it would be permanently empty.

Planned: push notifications (see the build brief's phasing).

## Develop

```bash
flutter pub get
flutter analyze
flutter test
flutter run            # on a connected device or emulator
```

Bundle id: `com.spencerfields.easypostmobilecompanion` (iOS + Android).

## Build & release

CI (`.github/workflows/build.yml`) builds a signed Android `.aab` and iOS `.ipa`
once signing secrets are set — see [CI-MOBILE-SETUP.md](CI-MOBILE-SETUP.md).
