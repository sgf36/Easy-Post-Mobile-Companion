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

## Status — Phase 0 (spike)

- QR / review-code pairing → secure-enclave credential storage
- Live trackers list via the proxy

Planned: push notifications, HTS lookup, insurance/claims/pickups, history and
reports (see the build brief's phasing).

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
