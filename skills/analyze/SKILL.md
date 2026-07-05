---
name: analyze
description: "Analytics & insight phase — turn Substack, Medium, and LinkedIn stats into a data-backed audit of content quality AND outreach, with concrete next actions mapped to the writing/distribution skills. Ingests normalized records from the substack-stats / medium-stats / linkedin-stats skills (or manual data), finds what's working and what's leaking reach, reads the cross-platform funnel, and ends with a prioritized action list plus a 'what to write next'. Use whenever someone asks how to improve their outreach, why a post under- or over-performed, what to write next, or wants an analysis/audit of their publishing across platforms. This is Phase 5 — it closes the loop back into explore/write/distribute."
---

# Analyze & Improve

Turn the numbers for **$ARGUMENTS** into decisions. This skill owns **Phase 5 (Measure)** of the pipeline:
it reads what happened across LinkedIn, Substack, and Medium and tells the person what to do differently —
then routes each fix back to the skill that executes it.

## Step 1 — get the data

Pull stats first via the gathering skills — **`substack-stats`**, **`medium-stats`**, **`linkedin-stats`** —
each of which parses the analytics **exports the person downloads** from the platform (Substack ZIP / Dashboard
Stats, Medium GraphQL / Stats, LinkedIn XLSX), with an optional public fetch for inventory. If the person
already has exports/pastes, ingest those directly. Aim for at least two platforms before drawing
cross-platform conclusions; one platform is fine for a single-platform audit.

## The normalized record (canonical schema — the gathering skills produce this)

Per post (`PostRecord`), nulls where a platform lacks a field:

| field | meaning |
|---|---|
| `platform` | substack / medium / linkedin |
| `id`, `title`, `url`, `publishDate` | identity + timing (ISO date) |
| `format` | newsletter / article / listicle / carousel / post |
| `topics` | tags / subject |
| `impressions` | times shown (LinkedIn) |
| `views` | views / opens (Substack, Medium) |
| `reads`, `readRatio` | full reads and reads÷views (Medium's quality signal) |
| `reactions` | likes / claps / reactions, one number |
| `comments`, `shares` | comments; shares / reposts |
| `clickThrough` | outbound link clicks, where reported |
| `audience` | free / paid / everyone |
| `source` | export / public (confidence + coverage flag) |

Plus one `AccountSummary` per platform: `subscribers`, `paidSubscribers`, `followers`, `subscriberDelta`,
`followerDelta`, `openRate`, `rangeDays`, `source`.

**Normalize before comparing.** Raw counts favor whoever has the bigger audience. Compute rates —
engagement ÷ reach (reactions/impressions or reactions/views), read-ratio, click-through ÷ reach — so a
small-audience post that punched above its weight stays visible. Flag any metric that's `null` or
`source: public` so a coverage gap isn't read as a zero.

**Watch these measurement traps (each drawn from real data):**

- **Reach ≠ right reach.** The single highest-*impressions* post is often a personal/off-topic one that
  spread through a legacy network at a *low* engagement rate — big number, wrong audience. Rank by engagement
  rate; call out such outliers instead of letting them define "what works."
- **Substack open rate is inflated by Gmail's image proxy** (opens logged as `US` regardless of location).
  Treat it as a directional *title* signal; for real engagement use unique-subscriber opens from the export.
- **Subscriber/follower growth is usually publish-day driven.** Map each signup's date to the post that ran
  that day (Substack `email_list.csv` `created_at`, LinkedIn daily new-followers). If every publish converts,
  the growth lever is *volume of top-of-funnel*, not a better post — say so.
- **Demographics are the ICP.** LinkedIn's demographics sheet (location, seniority, title, industry) tells you
  who you're actually reaching — check the content matches them, and name the ICP explicitly.

## Step 2 — the audit (do both halves)

### A. Content quality — what wins and why
- **Top vs bottom quartile** by normalized engagement. What do the winners share — topic, format, angle,
  title/hook shape? What do the losers share?
- **Titles & hooks:** which openings drove reach (impressions/views) vs which drove *depth* (read-ratio,
  comments). A high-view / low-read-ratio piece is a title that overpromised — a writing fix, not a reach one.
- **Format:** carousel vs essay vs listicle vs HTML article — which format serves which topic best.
- **Series lift:** do posts in a series outperform standalones? Is the callback/tease actually compounding?

### B. Outreach / reach — where growth comes from and where it leaks
- **Timing & cadence:** publish-time vs performance; is there a consistent, repeatable schedule? Gaps and
  bursts both hurt the recommendation engines.
- **Reach leaks:** high impressions + low click-through, or high views + low read-ratio, or high reach + low
  follower/subscriber conversion — name the specific leak, not just "engagement is low".
- **Conversion:** subscriber/follower delta against the posts that ran in the window — which pieces actually
  grew the audience.

### C. Cross-platform funnel
Read the three platforms as one funnel: **LinkedIn (discovery) → Substack (subscribe) → Medium (depth).**
Which topics win on which platform? Is the same thesis carrying across, or drifting?

- **Compute the actual conversion rate**, not a vibe: LinkedIn members-reached → Substack subscribers. A large
  reach with a tiny subscriber delta is the leak, and it's usually two fixable things — no subscribe CTA / link
  in the LinkedIn post (links belong in the *first comment*), and no link out of the Substack email.
- **Discovery is not evenly distributed.** One platform typically carries almost all reach (often LinkedIn);
  another (often Medium) may get near-zero organic discovery despite a *decent read-ratio* — meaning its
  content is fine but nothing feeds it. Don't read low Medium reach as low Medium quality; the fix is driving
  traffic to it (canonical + links from LinkedIn/Substack), or consciously de-prioritizing it.

## Step 3 — recommendations, mapped to the skills that execute them

Every finding must become an action pointed at a specific skill:

- Framing / topic selection / angle → **`explore`** (re-lock a stronger spine or pick better topics)
- Hook / title / format / structure → **`write-linkedin` · `write-substack` · `write-medium`**
- Timing / tags / cross-posting / canonical / launch Note → **`distribute`**
- Restructure a specific underperformer → **`refine`**

End with:
1. **A prioritized action list** — highest-leverage first, each tied to a skill and a why-from-the-data.
2. **"What to write next"** — 2–3 concrete topic/format/platform bets grounded in what the winners share.

## Optional — trend over time

Offer to save the normalized dataset (e.g. `./content-studio-stats.json` in the project, or the scratchpad)
so the next run can show trend-over-time (are the recommendations working?). Opt-in only; never auto-upload.
Keep all analytics local — they're personal data.
