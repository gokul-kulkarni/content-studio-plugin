---
name: linkedin-stats
description: "Turn LinkedIn analytics into the normalized record shape the analyze skill reads — post impressions, reach, reactions, comments, reposts, follower growth, and audience demographics — from the native analytics export you download. Use whenever someone asks how their LinkedIn posts are doing, wants impressions/reach numbers, asks which carousel performed best, or is gathering data for an outreach/quality analysis."
---

# LinkedIn Stats

Turn the numbers for **$ARGUMENTS** (a LinkedIn creator) into the normalized record shape `analyze` reads.
LinkedIn gates analytics behind approved partner vendors and blocks unauthenticated access, so the **native
export is the source** — **you download it and drop it in**; this skill parses it.

## The export (XLSX)

Your profile → **Analytics** (creator view) → **Export** → downloads an **XLSX**. The aggregate export has five
sheets, each worth reading:

- **DISCOVERY** — total impressions + members reached for the window.
- **ENGAGEMENT** — daily impressions + engagements (spot the launch inflection and best days).
- **TOP POSTS** — two *separate* rankings side by side: top posts by **engagements** and top posts by
  **impressions** (URLs + dates). They rarely match — compute engagement rate (engagements ÷ impressions) to
  see which posts were genuinely strong vs merely widely shown.
- **FOLLOWERS** — total followers + daily new-follower counts (map signups to publish days).
- **DEMOGRAPHICS** — company / location / seniority / job title / industry of your audience. This is the
  richest ICP signal any platform gives you — pass it to `analyze` verbatim.

Parse the XLSX directly (it's a zip of sheet XML; read `sharedStrings.xml` + each `sheetN.xml`, or use a
spreadsheet lib). For a single post, **"View analytics"** on the post shows impressions/reach/engagement — a
paste works too.

> ⚠️ **Reach ≠ right reach.** LinkedIn's top-*impressions* post is often a personal/off-topic one that spread
> through your legacy network at a *low* engagement rate and the *wrong* audience. Rank by engagement rate, not
> raw impressions, so a viral-but-off-target post isn't mistaken for a content win. Flag such outliers for
> `analyze` rather than averaging them in.

## What to produce

Emit the normalized records (schema in the **`analyze`** skill): one `PostRecord` per post with
`impressions`, `reactions`, `comments`, `shares` (reposts) filled where available, `format` = `carousel`/`post`,
plus an `AccountSummary` for follower count/growth. Note the source (`export`). The **demographics** sheet has
no place in the per-post schema — carry it alongside as ICP context for `analyze`. Then hand off to
**`analyze`**.

## Privacy

Personal analytics — keep them local, never send to an external service.
