# Capture iOS App Store screenshots (Cloud Mac)

**For a Claude instance on Spencer's Cloud Mac.** Goal: run Easy-Post Mobile
Companion in the iOS Simulator, pair it with the demo review code, and capture
App Store-ready screenshots. First get the app running via
`RUN-ON-MAC-SIMULATOR.md`, then follow the steps here.

## 1. Boot a 6.7" iPhone simulator
App Store Connect requires 6.7" (or 6.9") iPhone screenshots. Use a Pro Max:

```bash
xcrun simctl list devices available | grep -i "Pro Max"      # find an available one
xcrun simctl boot "iPhone 15 Pro Max"                        # or 16 Pro Max
open -a Simulator
```
Its screenshots are 1290×2796 (6.7") — accepted by App Store Connect.

## 2. Run the app on that simulator
```bash
cd Easy-Post-Mobile-Companion
flutter run -d "iPhone 15 Pro Max"
```

## 3. Pair with the demo review code
The simulator has no camera, so use the review path:
1. Tap **"Enter review code instead"**.
2. Type **`epmc-demo-7f3a9c2e`** → **Pair**.
3. The **Tracking** screen loads with the demo shipments. (If it looks sparse,
   Spencer can run the seed script on Windows first to add varied statuses.)

## 4. Capture the screenshots
`xcrun simctl io booted screenshot` grabs the current simulator screen at the
correct resolution. Capture these, navigating the app between shots:

```bash
mkdir -p ~/Desktop/asc-screenshots
# a) Tracking list (sorted, carrier colours + status icons)
xcrun simctl io booted screenshot ~/Desktop/asc-screenshots/01-tracking.png
# b) Filter sheet — tap the filter icon (top right), then:
xcrun simctl io booted screenshot ~/Desktop/asc-screenshots/02-filter.png
# c) Tracker detail with the journey map — tap a shipment, then:
xcrun simctl io booted screenshot ~/Desktop/asc-screenshots/03-detail-map.png
# d) Scan-history timeline — scroll the detail page down, then:
xcrun simctl io booted screenshot ~/Desktop/asc-screenshots/04-history.png
# e) Pairing screen — unpair (link-off icon), then:
xcrun simctl io booted screenshot ~/Desktop/asc-screenshots/05-pairing.png
```

Aim for 3–5 clean shots. Avoid the status bar showing anything odd; the
simulator clock/battery are fine.

## 5. Hand them back
Zip `~/Desktop/asc-screenshots` and send it to Spencer (or drop into a shared
location). He'll upload them to App Store Connect, or hand them to the Windows
Claude to upload via the App Store Connect browser session.

Notes:
- These are **demo/test** shipments — fine for the store listing (they show the
  UI, not real customer data).
- If `flutter run` targets the wrong device, list with `flutter devices` and pass
  the simulator's id to `-d`.
