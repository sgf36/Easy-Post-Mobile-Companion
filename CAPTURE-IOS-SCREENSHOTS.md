# Capture iOS App Store screenshots (Cloud Mac)

**For a Claude instance on Spencer's Cloud Mac.** Goal: run Easy-Post Mobile
Companion in the iOS Simulator, pair it with the demo review code, and capture
App Store-ready screenshots of every major screen. Get the app running first via
`RUN-ON-MAC-SIMULATOR.md`, then follow the steps here.

The finished PNGs go back to Spencer, who (or the Windows Claude) uploads them to
App Store Connect → Easy-Post Mobile Companion → Distribution → 1.0 → Previews and
Screenshots.

---

## 1. Boot a 6.9-inch iPhone simulator

App Store Connect now **requires** the 6.9-inch iPhone size. Use a Pro Max — its
native screenshot resolution is accepted as-is (no resizing):

```bash
xcrun simctl list devices available | grep -iE "16 Pro Max|15 Pro Max"
# Prefer iPhone 16 Pro Max (1320x2868). iPhone 15 Pro Max (1290x2796) is also accepted.
xcrun simctl boot "iPhone 16 Pro Max"   # or "iPhone 15 Pro Max"
open -a Simulator
```

Confirm the size after the first capture with `sips -g pixelWidth -g pixelHeight`
— it must be one of 1320x2868 or 1290x2796.

## 2. Run the app on that simulator

```bash
cd Easy-Post-Mobile-Companion
flutter pub get
flutter run -d "iPhone 16 Pro Max"     # match the booted device name
```

(If `flutter run` picks the wrong device, list with `flutter devices` and pass the
simulator UDID to `-d`.)

## 3. Pair with the demo review code

The simulator has no camera, so use the review path:

1. On the pairing screen tap **"Enter review code instead"**.
2. Enter **`epmc-demo-7f3a9c2e`** → **Pair**.
3. The **Tracking** screen loads with demo test-mode shipments across varied
   statuses (pre-transit, in transit, out for delivery, delivered, exception).

If the list looks sparse, Spencer can run the seed script on Windows first to add
livelier, varied trackers before you capture.

## 4. Capture the shot list

`xcrun simctl io booted screenshot` grabs the current screen at full resolution.
Capture these six, navigating the app between shots via the hamburger menu
(top-left) and taps. Aim for clean frames — no half-open menus.

```bash
mkdir -p ~/Desktop/asc-screenshots
S=~/Desktop/asc-screenshots

# 1) TRACKING — the colour-coded status list (flagship). Sorted, carrier colours,
#    status icons. This is the default screen after pairing.
xcrun simctl io booted screenshot $S/01-tracking.png

# 2) SHIPMENT DETAIL — tap an in-transit shipment; shows the scan timeline and the
#    journey map with pins. Wait ~2s for the map tiles + geocoded pins to render.
xcrun simctl io booted screenshot $S/02-detail-map.png

# 3) INSURANCE — open the drawer -> Insurance, then tap "Buy insurance" to show the
#    purchase form (tracking code, carrier, amount, from/to address).
xcrun simctl io booted screenshot $S/03-insurance.png

# 4) CLAIMS — drawer -> Claims -> "File a claim"; shows the claim form (type
#    dropdown, amount, email, description).
xcrun simctl io booted screenshot $S/04-claims.png

# 5) REPORTS — drawer -> Reports; the per-carrier spend breakdown.
xcrun simctl io booted screenshot $S/05-reports.png

# 6) HTS LOOKUP — drawer -> HTS Lookup; search e.g. "copper" and capture the
#    results with duty rates (an international-post tool).
xcrun simctl io booted screenshot $S/06-hts.png
```

All six are wanted, but Apple uses only the first three on the install sheet, so
keep **Tracking, Detail+map, and one management action (Insurance)** as the first
three in filename order.

## 5. Verify and hand back

```bash
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
