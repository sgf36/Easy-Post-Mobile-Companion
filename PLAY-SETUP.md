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

## Getting a build onto a phone before the first release publishes

The internal track's tester opt-in link — Testing > Internal testing > Testers >
**Copy link** — is greyed out until the app has been **published**. A first
release sits in "Pending publication" while Google reviews it, and no link
exists in the meantime. Being on the tester list does not help: there is nothing
to opt into yet.

**Internal app sharing** is the way round it. Different mechanism, no track and
no review, and it returns a URL that installs the exact bundle:

```bash
python "/c/Users/SpencerFields/OneDrive - Spencer Fields/Apps/Claude/easypost_mobile_companion/tool/play_upload.py" --share --aab "<path to app-release.aab>"
```

On the phone, internal app sharing has to be switched on first: **Play Store >
profile > Settings > About > tap "Play Store version" seven times**. Then open
the link.

This is a sideways step, not a replacement. Once the first release publishes,
the opt-in link appears and the internal track updates like any other app,
which is the point of the whole exercise.

## Keeping the key on a workstation

CI reads the key from the repository secret. For running the script by hand,
put it in the Windows credential store rather than leaving JSON in `Downloads`:

```bash
python -c "import keyring,sys;keyring.set_password('google-play-ci','play-ci',open(sys.argv[1],encoding='utf-8').read())" "/c/Users/SpencerFields/Downloads/claude-automation-apps-KEY.json"
```

The script falls back to it whenever `PLAY_SERVICE_ACCOUNT_JSON` is unset, so
after this the key exists in exactly two places that are meant to hold secrets
— the repository secret and the OS vault — and nowhere on disk. Delete the
download afterwards.

A key can be re-issued at any time from the same service account (Cloud Console
> that account > Keys > Add key). Old keys keep working until deleted, so
issuing a fresh one costs nothing.

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
