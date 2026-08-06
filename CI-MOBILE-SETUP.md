# Mobile CI signing setup

The `Build` workflow (`.github/workflows/build.yml`) always runs analyze + tests
and compiles both platforms. It produces **store-ready** artifacts only once the
signing secrets below exist — until then it builds a debug APK and a
`--no-codesign` iOS binary, so CI stays green from day one.

Set secrets in the repo: **Settings → Secrets and variables → Actions → New
repository secret**, or with `gh secret set NAME` (paste the value when prompted).

## Android — upload keystore (4 secrets)

Generate an upload keystore once (keep the `.jks` safe — losing it means you
can't update the app on Play without a key reset):

```powershell
& "$env:JAVA_HOME\bin\keytool.exe" -genkeypair -v -keystore upload-keystore.jks -keyalg RSA -keysize 2048 -validity 10000 -alias upload
```

Then base64-encode it (Windows has no `base64` command) and set the secrets:

```powershell
[Convert]::ToBase64String([IO.File]::ReadAllBytes("upload-keystore.jks")) | Set-Content -NoNewline keystore.b64
gh secret set ANDROID_KEYSTORE_BASE64 -R sgf36/Easy-Post-Mobile-Companion < keystore.b64
gh secret set ANDROID_KEYSTORE_PASSWORD -R sgf36/Easy-Post-Mobile-Companion   # the store password you chose
gh secret set ANDROID_KEY_ALIAS        -R sgf36/Easy-Post-Mobile-Companion    # "upload"
gh secret set ANDROID_KEY_PASSWORD     -R sgf36/Easy-Post-Mobile-Companion    # the key password you chose
```

## iOS — Apple Distribution (5 secrets)

Prerequisites in the Apple Developer portal:
1. **App ID** `com.spencerfields.easypostmobilecompanion` (done) with Push
   Notifications enabled.
2. **Apple Distribution certificate** → exported as a `.p12` (cert + private
   key) — you have this.
3. **App Store distribution provisioning profile** for that App ID + that
   certificate: Profiles → **+** → *App Store Connect* distribution → download
   the `.mobileprovision`. Note its **name**.

Encode and set:

```powershell
[Convert]::ToBase64String([IO.File]::ReadAllBytes("ios_distribution.p12"))        | Set-Content -NoNewline p12.b64
[Convert]::ToBase64String([IO.File]::ReadAllBytes("EasyPostMobile.mobileprovision")) | Set-Content -NoNewline profile.b64
gh secret set IOS_P12_BASE64              -R sgf36/Easy-Post-Mobile-Companion < p12.b64
gh secret set IOS_P12_PASSWORD            -R sgf36/Easy-Post-Mobile-Companion   # the .p12 export password
gh secret set IOS_PROVISION_PROFILE_BASE64 -R sgf36/Easy-Post-Mobile-Companion < profile.b64
gh secret set IOS_PROVISION_PROFILE_NAME  -R sgf36/Easy-Post-Mobile-Companion   # the profile's exact name
gh secret set APPLE_TEAM_ID               -R sgf36/Easy-Post-Mobile-Companion   # 7WA4F8P743
```

## TestFlight auto-upload (2 more secrets)

With these set, a push to `main` uploads the signed `.ipa` straight to App Store
Connect (TestFlight). Without them, the signed `.ipa` is still a downloadable
artifact you can upload with Apple's Transporter app.

```powershell
gh secret set APPLE_ID           -R sgf36/Easy-Post-Mobile-Companion   # your Apple ID email
gh secret set APPLE_APP_PASSWORD -R sgf36/Easy-Post-Mobile-Companion   # app-specific password
```

- Generate the **app-specific password** at appleid.apple.com → Sign-In & Security
  → App-Specific Passwords (label it e.g. "EasyPost CI"). It is not your normal
  Apple ID password.
- The **first** TestFlight build needs a one-time **export-compliance** answer in
  App Store Connect (the app uses only standard HTTPS, so "no non-exempt
  encryption") before it becomes installable.

## Notes

- The iOS signed path is the standard `flutter build ipa` + manual-signing
  sequence. The first run with secrets may need a small tweak (archive signing
  is fiddly on CI) — tell me when the secrets are in and I'll confirm the run and
  fix anything, exactly as we did for the desktop Mac App Store build.
- Nothing here is needed to keep CI green: without secrets it still analyzes,
  tests, and compiles both platforms.
