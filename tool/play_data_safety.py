# -*- coding: utf-8 -*-
"""Fill the Data safety CSV from the analysis in PLAY-APP-CONTENT.md.

Edits Google's own export in place rather than authoring a CSV, so every
question ID is theirs and nothing is invented. Rows not named here keep the
value the export had, which for an unanswered question is blank.

Google's export is the input, so every question ID is theirs and none is
invented. Rows this script does not name keep whatever the export had.

    DATA_SAFETY_CSV=<export.csv> python3 tool/play_data_safety.py
    DATA_SAFETY_CSV=<export.csv> python3 tool/play_data_safety.py --submit

Export it from Play Console > App content > Data safety. There is no way to
read the current declaration back — the endpoint is POST-only — so the export
is the only source of the current question set, and it changes as Google
revises the form.
"""
import csv
import io
import os
import sys

SRC = os.environ.get("DATA_SAFETY_CSV", "data_safety_export.csv")
OUT = os.environ.get("DATA_SAFETY_OUT", "data_safety_filled.csv")

Q = "Question ID (machine readable)"
R = "Response ID (machine readable)"
V = "Response value"
REQ = "Answer requirement"
L = "Human-friendly question label"

PRIVACY_URL = "https://easy-post.spencerfields.com/mobile-privacy.html"

# The three types the backend actually persists. Everything else the app touches
# is forwarded to EasyPost and never written — ephemeral, and so out of scope.
TYPES = ["PSL_DEVICE_ID", "PSL_PURCHASE_HISTORY", "PSL_USER_INTERACTION"]

# (question id, response id) -> value. A response id of "" means the value sits
# on the question itself.
ANSWERS = {
    # Device or other IDs — the device token and the push token.
    ("PSL_DATA_TYPES_IDENTIFIERS", "PSL_DEVICE_ID"): "true",
    # Purchase history — license_order and license_tier, which bind a device to
    # the licence it was paired under.
    ("PSL_DATA_TYPES_FINANCIAL", "PSL_PURCHASE_HISTORY"): "true",
    # App interactions — last_seen, stamped on each call.
    ("PSL_DATA_TYPES_APP_ACTIVITY", "PSL_USER_INTERACTION"): "true",

    # Unpairing revokes the device and deletes its row, so deletion is
    # supported. The privacy policy is the page that documents how.
    ("PSL_SUPPORT_DATA_DELETION_BY_USER", "DATA_DELETION_YES"): "true",
    ("PSL_DATA_DELETION_URL", ""): PRIVACY_URL,
}

for t in TYPES:
    base = f"PSL_DATA_USAGE_RESPONSES:{t}"
    # Collected, never shared. EasyPost receives a shipment request as the
    # service being called, which Google treats as processing on the
    # developer's behalf rather than sharing — so no sharing purpose is set.
    ANSWERS[(f"{base}:PSL_DATA_USAGE_COLLECTION_AND_SHARING", "PSL_DATA_USAGE_ONLY_COLLECTED")] = "true"
    # Not ephemeral: these three are written to the devices table and persist
    # until the device is unpaired. Answered explicitly rather than left blank,
    # because blank on a MAYBE_REQUIRED question is not an answer.
    ANSWERS[(f"{base}:PSL_DATA_USAGE_EPHEMERAL", "")] = "false"
    # The app cannot be used without pairing, so this is not optional.
    ANSWERS[(f"{base}:DATA_USAGE_USER_CONTROL", "PSL_DATA_USAGE_USER_CONTROL_REQUIRED")] = "true"
    # App functionality only. Not analytics, not advertising, not
    # personalisation — none of which this app does.
    ANSWERS[(f"{base}:DATA_USAGE_COLLECTION_PURPOSE", "PSL_APP_FUNCTIONALITY")] = "true"


def main() -> int:
    with io.open(SRC, encoding="utf-8-sig", newline="") as fh:
        reader = csv.DictReader(fh)
        fields = reader.fieldnames
        rows = list(reader)

    seen = set()
    changed = []
    for row in rows:
        key = (row[Q], row[R])
        if key in ANSWERS:
            seen.add(key)
            before = row[V]
            row[V] = ANSWERS[key]
            if before != row[V]:
                changed.append((row[Q], row[R], before, row[V], row[L]))

    missing = set(ANSWERS) - seen
    if missing:
        print("These answers matched no row in the export — refusing to submit:")
        for m in sorted(missing):
            print("  ", m)
        return 1

    with io.open(OUT, "w", encoding="utf-8", newline="") as fh:
        w = csv.DictWriter(fh, fieldnames=fields)
        w.writeheader()
        w.writerows(rows)

    print(f"{len(changed)} answers set, written to {OUT}\n")
    for qid, rid, before, after, label in changed:
        short = label.split("/")[-1][:46]
        print(f"  {qid.replace('PSL_DATA_USAGE_RESPONSES:', ''):58} {rid or '(value)':38} {after:6}  {short}")

    # Everything still unanswered, so nothing is filed by accident.
    groups = {}
    for row in rows:
        groups.setdefault(row[Q], []).append(row)
    still = [q for q, items in groups.items()
             if not any((i[V] or "").strip() for i in items) and items[0][REQ] == "REQUIRED"]
    print("\nREQUIRED questions still blank:", still or "none")

    if "--submit" not in sys.argv:
        print("\nNot submitted. Re-run with --submit.")
        return 0

    sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
    import requests
    from play_upload import credentials, access_token, BASE, PACKAGE

    body = io.open(OUT, encoding="utf-8").read()
    r = requests.post(
        f"{BASE}/applications/{PACKAGE}/dataSafety",
        headers={"Authorization": "Bearer " + access_token(credentials()),
                 "Content-Type": "application/json"},
        json={"safetyLabels": body}, timeout=300)
    print(f"\nPOST dataSafety -> {r.status_code} {r.text[:800]}")
    return 0 if r.status_code < 400 else 1


if __name__ == "__main__":
    raise SystemExit(main())
