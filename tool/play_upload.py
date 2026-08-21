#!/usr/bin/env python3
"""Upload an App Bundle to a Google Play track.

Talks to the Play Developer API directly rather than through fastlane or a
third-party action. The whole protocol is four REST calls around an "edit",
and owning them means no supply-chain surface on the one credential that can
publish this app, and no Ruby toolchain in a Flutter repo.

Auth is a service-account JWT exchanged for an access token, the same shape as
the App Store Connect side. The key never leaves the process.

    python3 tool/play_upload.py --aab build/app/outputs/bundle/release/app-release.aab

Credentials come from PLAY_SERVICE_ACCOUNT_JSON, which may be the JSON itself
or a path to it. See PLAY-SETUP.md for how it is created and what it is allowed
to do.

The default track is `internal`, which is the one that reaches named testers
immediately and reaches nobody else. Production is refused outright: a release
to the public should be a deliberate act in the Console, not a flag on a script
that also does routine test uploads.
"""
from __future__ import annotations

import argparse
import json
import os
import sys
import time

import jwt
import requests

PACKAGE = "com.spencerfields.easypostmobilecompanion"
BASE = "https://androidpublisher.googleapis.com/androidpublisher/v3"
UPLOAD = "https://androidpublisher.googleapis.com/upload/androidpublisher/v3"
SCOPE = "https://www.googleapis.com/auth/androidpublisher"
TOKEN_URL = "https://oauth2.googleapis.com/token"

# `production` is deliberately absent. See the module docstring.
TRACKS = ("internal", "alpha", "beta")


def credentials() -> dict:
    raw = os.environ.get("PLAY_SERVICE_ACCOUNT_JSON", "").strip()
    if not raw:
        sys.exit("PLAY_SERVICE_ACCOUNT_JSON is not set — see PLAY-SETUP.md")
    if not raw.startswith("{"):
        if not os.path.exists(raw):
            sys.exit(f"PLAY_SERVICE_ACCOUNT_JSON points at {raw}, which does not exist")
        raw = open(raw, encoding="utf-8").read()
    try:
        info = json.loads(raw)
    except json.JSONDecodeError as e:
        sys.exit(f"PLAY_SERVICE_ACCOUNT_JSON is not valid JSON: {e}")
    for field in ("client_email", "private_key", "token_uri"):
        if field not in info:
            sys.exit(f"service account JSON has no {field!r} — is this the right file?")
    return info


def access_token(info: dict) -> str:
    """Self-signed JWT exchanged for a bearer token.

    Google caps the assertion at an hour. Unlike App Store Connect it does not
    object to an `iat` of exactly now, but a minute of backdating costs nothing
    and survives a runner whose clock has drifted.
    """
    now = int(time.time())
    assertion = jwt.encode(
        {
            "iss": info["client_email"],
            "scope": SCOPE,
            "aud": info.get("token_uri", TOKEN_URL),
            "iat": now - 60,
            "exp": now + 3540,
        },
        info["private_key"],
        algorithm="RS256",
    )
    r = requests.post(
        info.get("token_uri", TOKEN_URL),
        data={"grant_type": "urn:ietf:params:oauth:grant-type:jwt-bearer",
              "assertion": assertion},
        timeout=60,
    )
    if r.status_code >= 400:
        sys.exit(f"token exchange failed: {r.status_code}\n{r.text[:1000]}")
    return r.json()["access_token"]


class Play:
    def __init__(self, token: str, package: str):
        self.h = {"Authorization": f"Bearer {token}"}
        self.package = package

    def _check(self, r, what):
        if r.status_code >= 400:
            detail = r.text[:1500]
            # The two that actually happen, named rather than left as a code.
            if r.status_code == 401:
                detail += "\n\nThe service account is not authorised. Grant it "\
                          "access to this app in Play Console > Users and permissions."
            if r.status_code == 404:
                detail += f"\n\nNo app {self.package!r} visible to this service "\
                          "account. Either the app has not been created in Play "\
                          "Console, or the account has no permission on it."
            sys.exit(f"{what} failed: {r.status_code}\n{detail}")
        return r.json() if r.content else {}

    def new_edit(self) -> str:
        r = requests.post(f"{BASE}/applications/{self.package}/edits",
                          headers=self.h, timeout=120)
        return self._check(r, "creating an edit")["id"]

    def upload_bundle(self, edit: str, path: str) -> int:
        size = os.path.getsize(path)
        print(f"  uploading {os.path.basename(path)} ({size // (1024 * 1024)}MB)")
        with open(path, "rb") as fh:
            r = requests.post(
                f"{UPLOAD}/applications/{self.package}/edits/{edit}/bundles",
                headers={**self.h, "Content-Type": "application/octet-stream"},
                params={"uploadType": "media"}, data=fh, timeout=1800,
            )
        return self._check(r, "uploading the bundle")["versionCode"]

    def set_track(self, edit: str, track: str, version_code: int, notes: str | None):
        release = {"versionCodes": [str(version_code)], "status": "completed"}
        if notes:
            release["releaseNotes"] = [{"language": "en-GB", "text": notes}]
        r = requests.put(
            f"{BASE}/applications/{self.package}/edits/{edit}/tracks/{track}",
            headers={**self.h, "Content-Type": "application/json"},
            data=json.dumps({"track": track, "releases": [release]}), timeout=120,
        )
        return self._check(r, f"assigning to the {track} track")

    def commit(self, edit: str):
        r = requests.post(f"{BASE}/applications/{self.package}/edits/{edit}:commit",
                          headers=self.h, timeout=300)
        return self._check(r, "committing the edit")

    def delete(self, edit: str):
        requests.delete(f"{BASE}/applications/{self.package}/edits/{edit}",
                        headers=self.h, timeout=60)


def main() -> int:
    p = argparse.ArgumentParser(description=__doc__,
                                formatter_class=argparse.RawDescriptionHelpFormatter)
    p.add_argument("--aab", default="build/app/outputs/bundle/release/app-release.aab")
    p.add_argument("--track", default="internal", choices=TRACKS)
    p.add_argument("--notes", default=None, help="release notes for testers")
    p.add_argument("--check", action="store_true",
                   help="authenticate and read the app back, upload nothing")
    args = p.parse_args()

    info = credentials()
    print(f"service account: {info['client_email']}")
    play = Play(access_token(info), PACKAGE)

    if args.check:
        # Creating and discarding an edit is the cheapest proof that the
        # credential works AND that it can see this particular app. A token
        # alone proves neither.
        edit = play.new_edit()
        print(f"  edit {edit} created and discarded — access confirmed")
        play.delete(edit)
        return 0

    if not os.path.exists(args.aab):
        sys.exit(f"no bundle at {args.aab}")

    edit = play.new_edit()
    print(f"edit {edit}")
    try:
        code = play.upload_bundle(edit, args.aab)
        print(f"  versionCode {code}")
        play.set_track(edit, args.track, code, args.notes)
        print(f"  assigned to {args.track}")
        play.commit(edit)
        print(f"committed — versionCode {code} is live on {args.track}")
    except SystemExit:
        # An uncommitted edit expires on its own, but leaving it lying around
        # makes the next run's error list confusing.
        play.delete(edit)
        raise
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
