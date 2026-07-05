---
name: medium-stats
description: "Turn Medium analytics into the normalized record shape the analyze skill reads — per-post (or aggregate) views, reads, read-ratio, and claps, plus follower/subscriber gains. Works from what you download or paste: the GraphQL stats response, a Stats-page export/paste, or the public RSS inventory. Use whenever someone asks how their Medium articles are doing, wants views/reads/claps, asks which story performed best or why read-ratio is low, or is gathering data for an outreach/quality analysis."
---

# Medium Stats

Turn the numbers for **$ARGUMENTS** (a Medium author) into the normalized record shape `analyze` reads.
**You bring the data** — Medium locks stats behind an authenticated session, so download or paste it and this
skill parses it.

## Best source — the GraphQL stats response

On medium.com → **Stats**, open DevTools → Network and grab the **`postsAggregateTimeseriesStats`** GraphQL
response (this is where Medium's stats live now — the old REST path `/_/api/users/{id}/stats` 403s). Paste the
JSON. Field mapping:

- `presentations` = impressions, `viewers` = views, `readers` = reads (read-ratio = readers ÷ viewers).
- `netFollowersGained` / `netSubscribersGained` = audience deltas for the window.
- `points[]` = a daily breakdown (`timestamp` ms + `viewers`/`readers`) — useful for spotting which days moved.

This is per-window aggregate (not always per-post); note that when handing to `analyze`.

## Also useful — Stats export / paste

medium.com → **Stats** shows per-story views/reads/read-ratio/fans (Partner Program adds earnings). The
**"Medium Enhanced Stats"** browser extension downloads a per-article CSV (views, reads, read-ratio, fans,
claps). A pasted or screenshotted Stats table works too — this is where per-*post* numbers come from.

## Optional — public inventory (no download)

Medium's RSS feed is public. **WebFetch** it for article inventory, tags, publish dates, and body word count:

```
https://medium.com/feed/@<username>
```

**RSS carries no claps, views, or reads** — engagement only comes from the sources above. RSS is still useful
for topic/tag and cadence context.

**Read-ratio is Medium's key quality signal** (reads ÷ views). High views + low read-ratio means the title
pulled people in but the piece didn't hold them — flag those for `analyze`.

## What to produce

Emit the normalized records (schema in the **`analyze`** skill): one `PostRecord` per article (or an aggregate
record when only totals are available), with `views`, `reads`, `readRatio`, and `reactions` (claps) filled
where available, `topics` from RSS tags when you have them, and the rest `null`. Note the source
(`export` / `public`). Then hand off to **`analyze`**.

## Privacy

Personal analytics — keep them local, never send to an external service.
