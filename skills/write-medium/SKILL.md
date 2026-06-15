---
name: write-medium
description: "Writing phase for Medium — draft a publish-ready Medium article (output as clean semantic HTML, since Medium doesn't render pasted Markdown) from the LOCKED master content, tuned to Medium's reading experience and curation system. Use whenever someone wants to write a Medium article, post, or story, or turn a finalized idea into a Medium piece. Medium rewards depth, clarity, and completion (read ratio), and routes reach through curation, publications, and tags. Do not run until the content is locked and approved (see explore); to fix an existing rough draft, use refine."
---

# Write — Medium

Turn the **locked master content** for **$ARGUMENTS** into a Medium article. Medium is a *discovery-and-curation* platform with a built-in audience: a strong piece can reach readers far beyond your following if it gets curated, but the same piece lives or dies on the **read ratio** — the share of openers who finish. So hook fast and keep momentum.

## Preconditions & change protocol (read first)

- **Content first.** Only render once the master content is locked and the person has approved it (Phase 1 / **explore**). If it isn't, stop and finalize the content first.
- **One spine, faithful rendering.** This is the same thesis as the LinkedIn carousel and Substack essay, rendered for Medium — it reinforces, never duplicates.
- **Same running example** as every other asset.
- **Change protocol.** If the person asks to change the substance after this exists, don't patch it here — update the master content (**explore**), re-approve, and regenerate all platform assets (**refine** runs the re-sync).
- **Match the person's voice** — preserve first-person reflection and distinctive phrasing.

**Output the article as an HTML file, not Markdown.** Medium's editor doesn't render pasted Markdown — syntax like `##` and `**` shows up as literal characters. Medium expects HTML (or rich text), so deliver a clean semantic `.html` file the person can paste or import (see *Output format* below).

## Structure

- **Title** — clear, specific, and curiosity- or benefit-driven. The title carries both Google SEO and curation weight; vague or clever-but-opaque titles underperform.
- **Subtitle (kicker)** — one line under the title that adds the specific promise or the non-obvious angle. Medium displays it prominently in feeds and previews.
- **Feature image** — a strong hero image. It appears in the article, in Medium feed cards, and in the social/link preview when shared. (A 1.91:1 hero shared with the other channels works well — see the design-brief skill.)
- **A hook in the first 1–2 sentences.** Medium shows a preview and emails the opening; the read ratio is decided early. Drop the reader into a concrete moment, then pivot.
- **Sectioned body with subheadings** on every major beat. Medium is a reading experience — short paragraphs (1–3 sentences), generous whitespace, subheadings, and the occasional bullet list keep people scrolling.
- **One pull quote** for the single most quotable line (Medium's large-quote style). This is the screenshot-and-share moment and the line a curator remembers.
- **Depth without padding.** Medium rewards genuinely useful length, but the read ratio punishes filler — every section should earn its place.
- **A clear, open-ended ending** that lands the thesis and invites a response (responses are an engagement signal).
- **Series continuity** — if part of a series, recall the previous piece early and tease the next at the end.

## Format options

- **Narrative essay** — best for a thesis-driven technical argument: hook → sectioned build → payoff. Default for most ideas from the explore phase.
- **Listicle** — numbered, scannable structure. Consistently among Medium's highest-consumed formats; offer it when the idea naturally decomposes into discrete points.

## Output format (HTML, not Markdown)

Produce a clean, semantic HTML file. Use plain content tags only — no CSS, no inline styles, no `<div>` scaffolding — because Medium strips styling and maps recognized tags onto its own native elements:

- `<h1>` — the **title** (Medium uses the first `<h1>` as the story title).
- `<h2>` — the **subtitle/kicker** directly under the title, then `<h2>`/`<h3>` for section subheadings.
- `<p>` — body paragraphs. Keep them short (1–3 sentences).
- `<blockquote>` — the **pull quote**.
- `<ul>` / `<ol>` + `<li>` — lists (and the listicle structure).
- `<pre><code>` — code blocks (escape `<`, `>`, `&` inside them).
- `<figure><img src="..."><figcaption>…</figcaption></figure>` — the feature image and any inline images.
- `<a href="...">` for links, `<strong>` / `<em>` for emphasis.

Wrap it in a minimal `<html><body>…</body></html>` document so it opens and renders in a browser.

**Getting it into Medium, two paths:**
1. **Paste rendered HTML** — open the `.html` file in a browser, select all, copy, and paste into the Medium editor. Formatting (headings, quotes, lists, links, images) carries over — including images, when they're referenced with paths that resolve next to the file.
2. **Import a story** — if the piece is hosted at a URL, use Medium's *Import a story* tool, which also sets the canonical link (see the distribute skill for the cross-post/canonical strategy).

After import, confirm the title and subtitle landed as Medium's title/kicker, and replace any image placeholders with real uploads.

## Publishing levers (hand off to distribute)

Tags, choosing a publication, the Boost/curation angle, the member paywall and Friend Links, and the **canonical-URL import** (essential if the piece is already on Substack) all live in the **distribute** skill. Draft the article here, then go there to publish it for reach. For the feature image and inline section images, use the **design-brief** skill.
