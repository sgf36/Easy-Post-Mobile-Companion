# -*- coding: utf-8 -*-
"""Fill the Google Play store listing: text, contact details and graphics.

Only what the API can set. The App content declarations — content rating, data
safety, target audience, ads, privacy policy — have no endpoint in
androidpublisher v3 and stay in the Console.

    python play_listing.py --plan
    python play_listing.py --apply
"""
import argparse
import os
import sys

import requests

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from play_upload import credentials, access_token, BASE, UPLOAD, PACKAGE  # noqa: E402

REPO = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
ASSETS = os.path.join(REPO, "store", "play-assets")

LANGUAGE = "en-GB"  # the app's defaultLanguage; adding others is a separate pass

TITLE = "Easy-Post Mobile Companion"           # <= 30
SHORT = "Track parcels and refunds, as a companion to Easy-Post Desktop."  # <= 80

# House style: no Oxford commas, no abbreviations in prose, no pronouns.
# Claims are limited to what the app actually does. Buying insurance and filing
# claims were removed in 1.0.1 and are not mentioned; the app lists policies and
# claims that already exist, and reports on refunds requested from the desktop.
FULL = """Easy-Post Mobile Companion brings the Easy-Post shipping console to Android. It pairs with a licensed Easy-Post Desktop installation through a single scan of a QR code, then mirrors the desktop workflow on the move — with no keys to type and nothing held in the clear.

TRACK EVERY SHIPMENT
Follow live carrier progress across every parcel in one list, sorted or filtered on demand, colour-coded by carrier, with an unmistakable icon for each delivery status. Open any shipment for the full scan history and a map of the journey from origin to latest location.

MANAGE ON THE MOVE
• Review and cancel scheduled collections
• Follow every refund request from submitted through to refunded or rejected
• Browse the full shipment history at a glance

TOOLS FOR INTERNATIONAL POST
• Look up Harmonized Tariff Schedule codes from the United States International Trade Commission, ready to paste into a customs declaration
• Read a clear spending report broken down by carrier

IN YOUR LANGUAGE
The interface is available in 27 languages, with dates and delivery statuses written the way each one writes them. Carrier names are left as the carriers write them.

BUILT FOR PRIVACY
The production key never leaves the paired desktop in readable form. The companion holds only an encrypted device credential, and every request travels through a zero-custody relay that decrypts nothing it stores. Unpairing revokes the phone's access at any moment.

REQUIRES EASY-POST DESKTOP
A paid, activated Easy-Post Desktop licence is required to pair. Easy-Post Desktop is available for Windows and macOS from easy-post.spencerfields.com."""

CONTACT_EMAIL = "Apps@spencerfields.com"
CONTACT_WEBSITE = "https://easy-post.spencerfields.com/mobile.html"

# 03-insurance and 04-claims are captured but not listed, as on the App Store:
# the claims fixture carries no status, so that frame reads "Unknown" twice with
# no icon.
#
# These are the emulator captures against the demo fixtures. The 7 August set
# they replaced was taken against the live account and carried real-looking USPS
# tracking numbers — see the commit that recaptured them.
SCREENSHOTS = ["01-tracking.png", "02-detail-map.png", "05-reports.png",
               "06-hts.png", "07-refunds.png"]

GRAPHICS = {"icon": "icon-512.png", "featureGraphic": "feature-graphic-1024x500.png"}

LIMITS = {"title": 30, "shortDescription": 80, "fullDescription": 4000}


def main():
    p = argparse.ArgumentParser()
    p.add_argument("--apply", action="store_true")
    p.add_argument("--plan", action="store_true")
    args = p.parse_args()
    dry = not args.apply

    for field, value in (("title", TITLE), ("shortDescription", SHORT), ("fullDescription", FULL)):
        n = len(value)
        cap = LIMITS[field]
        print(f"{field:17} {n:5}/{cap}", "OK" if n <= cap else "OVER")
        if n > cap:
            sys.exit(f"{field} is over Play's limit")

    files = [os.path.join(ASSETS, n) for n in SCREENSHOTS] + \
            [os.path.join(ASSETS, n) for n in GRAPHICS.values()]
    missing = [f for f in files if not os.path.exists(f)]
    if missing:
        sys.exit(f"missing assets: {missing}")
    print(f"assets            {len(files)} present")

    if dry:
        print("\n--- full description ---")
        print(FULL)
        print("\n[plan] nothing sent. Re-run with --apply.")
        return

    h = {"Authorization": "Bearer " + access_token(credentials())}
    edit = requests.post(f"{BASE}/applications/{PACKAGE}/edits", headers=h, timeout=60).json()["id"]
    print(f"\nedit {edit}")

    def check(r, what):
        if r.status_code >= 400:
            requests.delete(f"{BASE}/applications/{PACKAGE}/edits/{edit}", headers=h, timeout=60)
            sys.exit(f"{what} failed: {r.status_code}\n{r.text[:1200]}")
        return r.json() if r.content else {}

    r = requests.put(
        f"{BASE}/applications/{PACKAGE}/edits/{edit}/listings/{LANGUAGE}",
        headers={**h, "Content-Type": "application/json"},
        json={"language": LANGUAGE, "title": TITLE,
              "shortDescription": SHORT, "fullDescription": FULL}, timeout=120)
    check(r, "listing")
    print(f"  listing {LANGUAGE} written")

    r = requests.put(
        f"{BASE}/applications/{PACKAGE}/edits/{edit}/details",
        headers={**h, "Content-Type": "application/json"},
        json={"defaultLanguage": LANGUAGE, "contactEmail": CONTACT_EMAIL,
              "contactWebsite": CONTACT_WEBSITE}, timeout=120)
    check(r, "details")
    print("  contact details written")

    def upload_image(kind, path):
        # Images hang off /listings/{language}/{imageType} — upload, list and
        # delete alike. The /images/ path in the reference does not answer at
        # all: it 404s with Google's HTML error page, which reads as a bad image
        # type rather than a bad path.
        #
        # No delete first. icon and featureGraphic hold one image and an upload
        # replaces it; deleting in the same edit lost the featureGraphic once,
        # with the upload still answering 200 and the committed listing carrying
        # nothing. Only the collection below is cleared, where appending really
        # would duplicate.
        with open(path, "rb") as fh:
            r = requests.post(
                f"{UPLOAD}/applications/{PACKAGE}/edits/{edit}/listings/{LANGUAGE}/{kind}",
                headers={**h, "Content-Type": "image/png"},
                params={"uploadType": "media"}, data=fh, timeout=600)
        check(r, f"{kind} {os.path.basename(path)}")
        print(f"  {kind:17} {os.path.basename(path)}")

    for kind, name in GRAPHICS.items():
        upload_image(kind, os.path.join(ASSETS, name))

    # phoneScreenshots is a collection; the delete clears it once, then each
    # upload appends in order. Skipped entirely when there is nothing fit to
    # send, rather than clearing the listing and leaving it with none.
    if SCREENSHOTS:
        requests.delete(
            f"{BASE}/applications/{PACKAGE}/edits/{edit}/listings/{LANGUAGE}/phoneScreenshots",
            headers=h, timeout=60)
    else:
        print("  phoneScreenshots  withheld, left as they are")
    for name in SCREENSHOTS:
        with open(os.path.join(ASSETS, name), "rb") as fh:
            r = requests.post(
                f"{UPLOAD}/applications/{PACKAGE}/edits/{edit}/listings/{LANGUAGE}/phoneScreenshots",
                headers={**h, "Content-Type": "image/png"},
                params={"uploadType": "media"}, data=fh, timeout=600)
        check(r, f"screenshot {name}")
        print(f"  phoneScreenshot   {name}")

    check(requests.post(f"{BASE}/applications/{PACKAGE}/edits/{edit}:commit",
                        headers=h, timeout=300), "commit")
    print("committed")

    # Read it back. An upload answering 200 is not the same as a committed
    # listing carrying the image — that exact gap swallowed a featureGraphic —
    # so the script disagrees with itself rather than reporting success twice.
    verify = requests.post(f"{BASE}/applications/{PACKAGE}/edits", headers=h, timeout=60).json()["id"]
    expected = {"icon": 1, "featureGraphic": 1, "phoneScreenshots": len(SCREENSHOTS)}
    wrong = []
    for kind, want in expected.items():
        r = requests.get(
            f"{BASE}/applications/{PACKAGE}/edits/{verify}/listings/{LANGUAGE}/{kind}",
            headers=h, timeout=60)
        got = len(r.json().get("images", [])) if r.status_code == 200 else -1
        print(f"  verified {kind:17} {got}/{want}")
        if got != want:
            wrong.append(f"{kind}: {got} not {want}")
    requests.delete(f"{BASE}/applications/{PACKAGE}/edits/{verify}", headers=h, timeout=60)
    if wrong:
        sys.exit("committed, but the listing does not match: " + "; ".join(wrong))
    print("listing verified")


if __name__ == "__main__":
    main()
