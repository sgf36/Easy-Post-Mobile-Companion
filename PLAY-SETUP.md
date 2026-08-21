# Publishing to Google Play from CI

An Android build reaches a phone the same way an iOS one reaches TestFlight:
CI builds the bundle and pushes it to a Play testing track. `tool/play_upload.py`
does the pushing; the `android` job calls it.

This replaces the direct APK download, which was a snapshot with no update
path — whoever installed one stayed on it until they noticed a newer one
existed and repeated the whole manual dance.

## What it needs

One secret on the repo, `PLAY_SERVICE_ACCOUNT_JSON`, holding a Google service
account key that Play Console has been told about. Without it the job prints a
notice and leaves the bundle in the `android` artifact; nothing fails.

## One-time setup

Steps 1 to 5 are done signed in as the Play developer account owner. Nothing
here can be scripted: Google has no API for granting API access to itself.

> **There is no "Setup > API access" page, and no Cloud project to link.**
> That was the old flow and it is what most guides still describe. Google
> retired it — its own documentation now states that you no longer need to link
> a developer account to a Google Cloud project. The service account is invited
> into Play Console like a person, by email address, under **Users and
> permissions**.

1. **Google Cloud** — at <https://console.cloud.google.com>, create a project
   (or reuse one) and enable the **Google Play Android Developer API**. The
   project is only somewhere for the service account to live; nothing links it
   to Play.

2. **Service account** — IAM & Admin > Service Accounts > Create. A name like
   `play-ci` is enough. It needs **no** Google Cloud role: its power comes from
   Play Console in step 4, not from Cloud IAM. Copy its email address, which
   looks like `play-ci@claude-automation-apps.iam.gserviceaccount.com`.

3. **Key** — on that service account, Keys > Add key > Create new key > **JSON**.
   The file downloads once and Google keeps no copy.

4. **Play Console** — <https://play.google.com/console>, at the **account**
   level rather than inside the app, go to **Users and permissions** >
   **Invite new users**.

   - Paste the service account email from step 2 into the email field. It is
     invited exactly as a person would be; there is no separate service-account
     list.
   - On the **App permissions** tab, **Add app**, choose *Easy-Post Mobile
     Companion*, and **Apply**. Granting it on the app rather than the account
     means a leaked key cannot touch anything else.
   - Enable **Release to testing tracks**. Leave *Release to production* and
     anything account-level off.
   - **Invite user** to save. There is no email to accept — a service account
     takes effect immediately.

   If **Users and permissions** is not in the sidebar, you are inside an app.
   Go up to "All apps" first; the item is account-level.

5. **The secret** — in Git Bash. The filename below is the one used on
   2026-08-21; a re-issued key will have a different suffix.

   Note the `<`. `gh secret set` reads the value from standard input, so the
   path is redirected into it rather than passed as an argument — given as an
   argument, gh rejects it. PowerShell has no `<` operator; there, use
   `Get-Content -Raw <path> | gh secret set PLAY_SERVICE_ACCOUNT_JSON --repo sgf36/Easy-Post-Mobile-Companion`.

   ```bash
   gh secret set PLAY_SERVICE_ACCOUNT_JSON --repo sgf36/Easy-Post-Mobile-Companion < "/c/Users/SpencerFields/Downloads/claude-automation-apps-50d08e28fe44.json"
   ```

   Redirecting the file means the key never appears in shell history or on a
   terminal.

## Checking it worked

```bash
PLAY_SERVICE_ACCOUNT_JSON="/c/Users/SpencerFields/Downloads/claude-automation-apps-50d08e28fe44.json" python "/c/Users/SpencerFields/OneDrive - Spencer Fields/Apps/Claude/easypost_mobile_companion/tool/play_upload.py" --check
```

`python`, not `python3`: the `python3` on PATH here is a shim in `~/bin` rather
than the 3.14 install the rest of this workspace uses.

`--check` creates an edit and immediately discards it. That proves both halves
— the key authenticates, *and* it can see this particular app. A token on its
own proves only the first, and step 4 is the half that usually goes wrong.

Once it passes, delete the downloaded key. The repository secret is now the
copy that matters, and the file in `Downloads` is a credential lying in the
open.

```bash
rm "/c/Users/SpencerFields/Downloads/claude-automation-apps-50d08e28fe44.json"
```

The two failures worth recognising:

| | |
|---|---|
| `401` | The key is valid but has no permission on this app. The invitation in step 4 was not saved, or the app was not added on the App permissions tab. |
| `404` | No such app, as far as this service account is concerned. Either the app has not been created in Play Console at all, or the permission was granted on a different one. |

A permission change can take a few minutes to reach the API. If step 4 looks
right and `--check` still fails, wait and run it again before changing anything.

## Nothing reaches a phone until the app is published once

Both routes to a device are gated on the same thing, and neither says so
clearly:

- The internal track's tester opt-in link — Testing > Internal testing >
  Testers > **Copy link** — is greyed out, saying the app must be published
  first. Being on the tester list does not help; there is nothing to opt into.
- **Internal app sharing**, which is normally the way round exactly this,
  refuses with `400 UploadException: NOT_PUBLISHED`.

A release can be uploaded and assigned to the internal track — versionCode 65
sits there with status `completed` — and still reach nobody, because Play will
not publish anything at all until the app's required setup is finished.

What is missing is readable over the API:

```
tracks:        internal, versionCode 65, status completed
store listing: en-GB, title only — no short description, no full description
app details:   defaultLanguage en-GB, nothing else
```

The store listing text and graphics **can** be set over the API
(`edits.listings`, `edits.images`). The declarations under **App content**
cannot: content rating, data safety, target audience, ads, and the privacy
policy have no endpoint in androidpublisher v3 and are Console-only. They are
also attestations about the product, so they belong to a person rather than to
a script.

Order of operations, once those are done: the internal release moves from
"Pending publication" to published, the opt-in link appears, and from the
second release onward the track updates like any other app — which is the point
of moving off the APK.

## Keeping the key on a workstation

CI reads the key from the repository secret. For running the script by hand,
the fallback is a file at `%LOCALAPPDATA%\easypost\play-ci.json`, which the
script finds without being told:

```bash
mkdir -p "/c/Users/SpencerFields/AppData/Local/easypost" && cp "/c/Users/SpencerFields/Downloads/claude-automation-apps-50d08e28fe44.json" "/c/Users/SpencerFields/AppData/Local/easypost/play-ci.json"
```

**Not** the Windows credential store, which is where the rest of this
workspace's secrets live. `CredWrite` caps a credential blob at 2560 bytes, and
a service-account key is about 2.4 KB of JSON — 4.7 KB once Windows encodes it
as UTF-16. It fails with `WinError 1783, "The stub received bad data"`, which
does not sound like a length limit.

Not Downloads, which a browser clears out, and not anywhere under OneDrive,
which would sync a private key to a server. `LOCALAPPDATA` is neither.

A key can be re-issued at any time from the same service account (Cloud Console
> that account > Keys > Add key). Old keys keep working until deleted.

## What CI does with it

The `android` job, after building the signed bundle:

- **on push to `main`** — uploads to the **internal** track
- **on `workflow_dispatch`** — uploads to the track chosen by the `play_track`
  input, which offers internal, alpha and beta
- **on a pull request** — nothing. A fork's PR must not be able to publish, and
  an internal release per PR would burn a versionCode each time.

`versionCode` is `github.run_number`, which is why it can only go up; the
version *name* comes from `pubspec.yaml`. Play refuses a versionCode it has
seen before, so a re-run of an old workflow cannot be uploaded — build again.

**Production is not offered**, here or in the script. Going public should be a
deliberate act in the Console, not a flag on the job that also does routine
test uploads.

## Why not fastlane, or an action from the Marketplace

The protocol is four REST calls around an "edit" object: open, upload bundle,
assign to a track, commit. Owning those four means no Ruby toolchain in a
Flutter repo, and no third party in the path of the one credential that can
publish this app.

## Notes on the account itself

The Play developer account is a **sole trader**, not an organisation — see
memory `project-google-play-account` for why the organisation route is a dead
end here. That matters for the **production** track, which requires a closed
test of twelve testers running for fourteen days first.

It does **not** affect the internal track, which is the one this automation
targets: internal testing takes up to 100 named testers and is available as
soon as the app exists in the Console.
