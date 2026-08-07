# Capture iOS App Store screenshots (Cloud Mac)

**For a Claude instance on Spencer's Cloud Mac.** Goal: run Easy-Post Mobile
Companion in the iOS Simulator, pair it with the demo review code, and capture
App Store-ready screenshots of every major screen. The capture is automated —
boot a simulator (step 1), run one command (step 2), hand back the zip (step 5).

Set the toolchain up first via `RUN-ON-MAC-SIMULATOR.md` (Xcode, an iOS
simulator runtime, Flutter 3.44.x, CocoaPods).

The finished PNGs go back to Spencer, who (or the Windows Claude) uploads them to
App Store Connect → Easy-Post Mobile Companion → Distribution → 1.0 → Previews and
Screenshots.

---

## 1. Boot a 6.9-inch iPhone simulator

App Store Connect now **requires** the 6.9-inch iPhone size. Use a Pro Max — its
native screenshot resolution is accepted as-is (no resizing):

```bash
xcrun simctl list devices available | grep -iE "1[567] Pro Max"
# Prefer iPhone 16 or 17 Pro Max (1320x2868). iPhone 15 Pro Max (1290x2796) is also accepted.
xcrun simctl boot "iPhone 16 Pro Max"
open -a Simulator
```

A fresh Xcode installs only the current generation's devices, so 16 Pro Max may
not exist yet. Create it — the device type ships with the runtime even when the
device does not:

```bash
xcrun simctl list runtimes                     # note the iOS runtime identifier
xcrun simctl create "iPhone 16 Pro Max" \
  com.apple.CoreSimulator.SimDeviceType.iPhone-16-Pro-Max \
  com.apple.CoreSimulator.SimRuntime.iOS-26-5  # match the runtime you have
```

If there are no runtimes at all, `xcodebuild -downloadPlatform iOS` fetches one
(~8.5 GB).

Confirm the size after the first capture with `sips -g pixelWidth -g pixelHeight`
— it must be one of 1320x2868 or 1290x2796.

## 2. Capture the shot list

`integration_test/screenshots_test.dart` walks the app and takes all six shots.
It drives the widget tree **in-process**, so it needs no macOS accessibility
permissions — which matters, because the Cloud Mac denies `osascript` assistive
access and synthetic clicks on the Simulator are therefore impossible.

The test cannot shell out from inside the simulator, so `tool/shotserver.py`
runs on the host: the test calls it at each clean frame, it takes the
native-resolution capture, and it answers only once the PNG is written. That
keeps the two in lockstep — no sleeping and hoping.

```bash
cd Easy-Post-Mobile-Companion
flutter pub get
python3 tool/shotserver.py &                                  # writes to ~/Desktop/asc-screenshots
flutter test integration_test/screenshots_test.dart -d "iPhone 16 Pro Max"
```

Expect `All tests passed!` and six PNGs. The run takes ~2 minutes after the
Xcode build. If `-d` picks the wrong device, list with `flutter devices` and pass
the simulator UDID instead.

The shots, in filename order:

| File | Screen |
|---|---|
| `01-tracking.png` | The colour-coded status list (flagship) — carrier colours, status icons |
| `02-detail-map.png` | An in-transit shipment: scan timeline + journey map with pins |
| `03-insurance.png` | Insurance → "Buy insurance": tracking code, carrier, amount, from/to address |
| `04-claims.png` | Claims → "File a claim": type dropdown, amount, email, description |
| `05-reports.png` | Reports: per-carrier spend breakdown |
| `06-hts.png` | HTS Lookup: "copper" results with duty rates |

All six are wanted, but Apple uses only the first three on the install sheet, so
keep **Tracking, Detail+map, and one management action (Insurance)** as the first
three in filename order.

## 3. How pairing works in the capture run

The simulator has no camera, so the QR scanner cannot be used. The test redeems
the review code **`epmc-demo-7f3a9c2e`** against `/pair/demo` directly and seeds
the pairing store before `main()` runs. `RootGate` then opens straight on
**Tracking**, with demo test-mode shipments across varied statuses (pre-transit,
in transit, out for delivery, delivered, return to sender, failed).

Seeding is not a shortcut — it is load-bearing. If `PairScreen` builds, it
constructs `MobileScanner`, and iOS raises a camera-permission alert that sits on
top of every capture. `xcrun simctl privacy … grant camera` does not survive
`flutter test`'s reinstall of the app, so the only reliable fix is never building
the scanner. The runbook does not want the pairing screen in the listing anyway.

If the tracker list looks sparse, Spencer can run the seed script on Windows
first to add livelier, varied trackers before you capture.

## 4. Manual fallback

If the automation is broken and you have a machine where you can actually tap the
Simulator, `xcrun simctl io booted screenshot` grabs the current screen at full
resolution. Run the app with `flutter run -d "iPhone 16 Pro Max"`, pair via
**"Enter review code instead"** → `epmc-demo-7f3a9c2e` → **Pair**, then navigate
with the hamburger menu (top-left) and capture each screen from the table above:

```bash
mkdir -p ~/Desktop/asc-screenshots
xcrun simctl io booted screenshot ~/Desktop/asc-screenshots/01-tracking.png
# …navigate, repeat for 02-detail-map … 06-hts
```

Aim for clean frames — no half-open menus, and give the detail screen ~2s for the
map tiles and geocoded pins to render.

## 5. Verify and hand back

```bash
S=~/Desktop/asc-screenshots
for f in $S/*.png; do echo "$f: $(sips -g pixelWidth -g pixelHeight "$f" | tail -2 | tr '\n' ' ')"; done
cd ~/Desktop && zip -r asc-screenshots.zip asc-screenshots
```

Send `asc-screenshots.zip` to Spencer (AirDrop, shared drive, or email). He uploads
them to App Store Connect, or hands them to the Windows Claude, which uploads them
through the open App Store Connect browser session (Distribution → 1.0 → Previews
and Screenshots → iPhone 6.9").

## Notes

- These are **demo/test-mode** shipments — correct for the store listing (they show
  the UI, not real customer data). The privacy label is "Data Not Collected".
- Do not capture the pairing/review-code screen for the store — it is an internal
  detail, not a selling point.
- Keep the simulator status bar as-is; Apple accepts the default clock/battery.
