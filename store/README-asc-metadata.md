# `asc-metadata.json` — what it is and where each field goes

28 App Store locales, matching the desktop listing so the two products offer the
same languages. Written to be fed straight to the App Store Connect API.

## The fields do not all live on the same resource

This is the part that costs an hour if nobody says it. Three of the four fields
hang off the **version**; the subtitle hangs off the **app info**.

| Field | Resource | Endpoint |
|---|---|---|
| `description` | `appStoreVersionLocalizations` | `POST/PATCH /v1/appStoreVersionLocalizations` |
| `keywords` | `appStoreVersionLocalizations` | as above |
| `promotionalText` | `appStoreVersionLocalizations` | as above |
| `subtitle` | `appInfoLocalizations` | `POST/PATCH /v1/appInfoLocalizations` |

`appInfoLocalizations` also carries `name`, which is **not** in this file: the
app is called Easy-Post Mobile Companion in every language, and sending the same
value 28 times only creates 28 chances to send it wrong.

## Limits, and how they were checked

Apple enforces: description 4000, keywords 100, promotional text 170, subtitle
30 — all in characters.

`test/asc_metadata_test.dart` fails the build if any field in any locale exceeds
its limit, so this is re-checked on every push rather than having been true once.
It also checks that keywords carry no space after a comma (Apple counts the
separator, so `a, b` spends a character on nothing), that no locale claims the
app buys or prints labels — it does not; that is the desktop app — and that the
"27 languages" claim still matches the number of ARB catalogues in `lib/l10n`.

The tightest field by a distance is the subtitle. German lands at 26 characters
and Hungarian at 29 against a limit of 30; neither has room for a longer verb.

## No `whatsNew`

Deliberately absent. Every version record here is an initial release and App
Store Connect rejects the attribute outright on one:

```
409 STATE_ERROR: Attribute 'whatsNew' cannot be edited at this time
```

## Screenshots are not in this file

They are binary uploads, not metadata. Seven languages have their own imagery —
`en de es fr hi ja zh` — and the other 21 locales fall back to the English set,
which is what both this listing and the Microsoft Store one already do. The
sources are in `store/asc-shots-<lang>/`, at 1320x2868 (6.9-inch). The app is
iPhone-only (`TARGETED_DEVICE_FAMILY = "1"`), so no iPad sizes are needed.
