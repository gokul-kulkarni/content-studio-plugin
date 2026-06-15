# Content Studio

A Claude plugin that turns a raw technical idea into coordinated, publish-ready content for **LinkedIn, Substack, and Medium** — written once as a single locked piece, then faithfully rendered for each platform.

Built for technical writers who cross-post the same thesis everywhere and want the versions to stay in sync.

---

## The core principle: content first, platforms second

The whole plugin runs on one rule:

> **Finalize the content fully and get explicit approval before generating any platform post. If the content changes after posts exist, update the master content first, get re-approval, then regenerate every platform asset — never patch one platform in isolation.**

This keeps LinkedIn, Substack, and Medium telling the *same* story instead of drifting apart after edits.

## The pipeline

```
 1. explore      → surface assumptions, ask for clarification,
                   lock the thesis + the master content   ── approval gate ──┐
                                                                             │
 2. write-*      → render the locked content per platform:                   │
                   write-linkedin · write-substack · write-medium           │
                                                                             │
 3. design-brief → one design hand-off artifact for Claude Design:           │
                   per-section images (Substack/Medium) + PDF slides (LinkedIn)
                                                                             │
 4. distribute   → timing, tags, SEO, launch Note, canonical cross-posting   │
                                                                             │
   refine        → restructure / fix any asset AND re-sync all platforms ────┘
                   (also the loop-back path when content changes)
```

**Phase 1 is a gate.** Nothing in Phases 2–4 starts until the person says the content is good.

**Change protocol (the loop-back arrow):** a content change at any later point sends you back to Phase 1 — update the master, re-approve, then regenerate *all* platform assets so they stay coordinated.

## Skills

| Skill | Phase | Does |
|---|---|---|
| `explore` | 1 | States assumptions up front, asks clarifying questions, runs an accuracy + framing pass, and locks the thesis spine and master content. The approval gate lives here. |
| `write-linkedin` | 2 | Carousel (slide-by-slide) + caption, from the locked content. Posted as a PDF document. |
| `write-substack` | 2 | Long-form essay in Markdown, native to Substack's reading/email format. |
| `write-medium` | 2 | Medium article as clean semantic **HTML** (Medium doesn't render pasted Markdown). |
| `refine` | 2–4 | Restructures rough drafts, clears confusions, and runs the cross-asset consistency + change-protocol re-sync. |
| `design-brief` | 3 | Produces a single **Claude Design hand-off artifact**: concise title + description per section (Substack/Medium images) and a slide-by-slide **PDF** brief (LinkedIn). |
| `distribute` | 4 | Posting timing, hashtags/tags, SEO description, Substack launch Note, Medium Boost/publications, canonical cross-posting, link hygiene. |

## Install

Copy this folder into your Claude plugins directory (or install from your marketplace). The plugin is defined by `.claude-plugin/plugin.json`; each skill lives under `skills/<name>/SKILL.md`.

## Design hand-off (Phase 3)

`design-brief` outputs one artifact you paste straight into **Claude Design**:

- **Substack & Medium** → a concise **title + description for every section** (one inline image per section, plus a shared 1.91:1 hero). Generated as light + dark variants.
- **LinkedIn** → a **slide-by-slide PDF carousel brief** (LinkedIn document posts are PDFs).
- A **shared visual identity** block (background, single accent, card style, mono labels, byline, aspect ratios) stated once so every image matches.

## Design principles baked in (learnings)

- **One spine, faithfully rendered.** Every platform carries the identical thesis; assets reinforce, never duplicate.
- **Lock framing before writing**, and lock the *content* before generating platform posts.
- **Medium needs HTML**, not Markdown — pasted `##`/`**` show up literally.
- **One concrete running example**, kept identical across every code snippet and every platform.
- **Series continuity:** if the piece is part of a series, open by referencing the previous post and end by teasing the next.
- **Consistent visual identity** across all images (shared background, accent, mono labels, byline), shipped as light + dark sets.
- **Platform image mechanics differ:** Substack images are uploaded manually at each section; Medium images carry over when you copy-paste the rendered HTML; LinkedIn ships a PDF.
- **Reach is won in distribution** (timing, cross-posting, canonical URLs), not in hashtags.

## License

MIT — see `LICENSE`.
