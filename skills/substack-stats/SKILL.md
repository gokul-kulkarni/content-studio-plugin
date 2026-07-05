---
name: substack-stats
description: "Turn Substack analytics into the normalized record shape the analyze skill reads — subscribers (free + paid), open rate, subscriber growth, and per-post views, opens, clicks, reactions, and comments. Works from the exports you download from Substack (the full ZIP export, the Dashboard Stats export, or a pasted table), with an optional public-endpoint fetch for reactions/comments. Use whenever someone asks how their Substack is doing, wants post-level or subscriber numbers, asks 'which essay performed best', or is gathering data for an outreach/quality analysis."
---

# Substack Stats

Turn the numbers for **$ARGUMENTS** (a Substack publication) into the normalized record shape that `analyze`
reads. **You bring the data** — download it from Substack and drop it in; this skill parses it. In rough order
of richness:

## Best source — the full export ZIP

Settings → **Export** produces a ZIP. It's the richest and most honest source:

- `posts.csv` — every post: `title`, `subtitle`, `audience` (everyone/only_paid), `type`, send times.
- `email_list.gokulkulkarni.csv` — every subscriber with `created_at`, `plan`, `email_disabled`,
  `first_payment_at`. **Map each `created_at` to the post that ran that day** to see which posts convert.
- `posts/NNN.delivers.csv` / `posts/NNN.opens.csv` — per-post subscriber-level delivery and **unique opens**,
  with device/geo. This is the only source of *true* unique-subscriber opens (vs. the inflated dashboard).

Parse the ZIP directly (unzip, read the CSVs). This gives subscriber growth, per-post reach/opens, loyal-reader
concentration, and list health (paid, unsubscribes) — everything except web view counts.

## Also useful — the Dashboard Stats export or a paste

Dashboard → **Stats** → export/download gives per-post **views** and open/click rates; the **Subscribers** tab
exports counts and growth. A pasted or screenshotted Stats table works too. Use this to fill web `views` that
the ZIP doesn't carry.

## Optional — public inventory (no download, no auth)

If there's no export handy, the public JSON endpoint gives reactions/comments/inventory. **WebFetch**:

```
https://<publication>.substack.com/api/v1/posts?limit=50&offset=0
```

Per post: `title`, `post_date`, `reaction_count`, `comment_count`, `audience`, `canonical_url`, `type`. This is
likes/comments/timing/free-vs-paid only — **no views, opens, or subscriber counts** (never public). Use the
publication subdomain (e.g. `yourname.substack.com`), not the reader profile `substack.com/@handle`.

> ⚠️ **Open rate is inflated by Gmail's image proxy.** Substack's "opens"/"open_rate" count image-proxy
> prefetches (Google opens the tracking pixel for the reader, logged as country `US` regardless of location).
> Treat open rate as a **directional title signal, not an absolute** — for the real number use `opens.csv`
> (unique subscriber opens) from the full export, and don't read `US` geo as real location. Pass this caveat
> to `analyze` with any open-rate figure.

## What to produce

Emit the normalized records (schema in the **`analyze`** skill): one `PostRecord` per post plus one
`AccountSummary`. Fill what you have, leave the rest `null`, and note the source (`export` / `public`) so
`analyze` can weight confidence. Then hand off to **`analyze`** — this skill gathers; `analyze` interprets.

## Privacy

These are personal analytics. Keep them local (the working dir or scratchpad); never post them to an external
service.
