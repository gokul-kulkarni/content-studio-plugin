---
name: design-brief
description: "Design hand-off — after the content is locked, produce ONE artifact a design tool (e.g. Claude Design) can execute: a concise title + description for every section (inline images + a shared hero) for Substack and Medium, and a slide-by-slide PDF brief for LinkedIn. Diagram-shaped visuals (the mental model, progressions, flows, systems, states) are rendered for real with archify when it's installed, as light/dark PNGs plus an interactive HTML. Use whenever someone wants graphics or visuals for their post, a carousel/PDF design spec, a hero/cover image, per-section images, asks 'should I make graphics for this?', or is handing content to a design tool and needs direction. Produces a brief plus rendered diagrams; hero and decorative art stay as a brief for the design tool."
---

# Design Hand-off Brief

Write a precise, executable brief for the visuals supporting **$ARGUMENTS**, as a **single artifact** the person pastes straight into Claude Design (or any design tool). Output a spec another tool can follow, and **render every diagram-shaped visual with archify** so the design tool only has to make the hero and the decorative art.

Run this **after the content is locked** (Phase 3). If sections change later, this artifact and its archify renders are stale — regenerate them (**refine** re-renders from each `candidate.json`).

## Diagrams: render them with archify (when available)

Before you write the brief, follow **[archify.md](archify.md)** in this skill's folder. It covers detection, choosing a type per beat, keeping labels on the running example, file layout, the exact commands, and the PNG frames.

- If archify is installed, render each diagram-shaped row (always including the **mental-model diagram**) and reference the produced files in the brief.
- If it isn't installed, offer the install command once and fall back to describing those rows in text, as below. Never block on it.

## Principle: fewer graphics, the right ones

LinkedIn is the visual platform (the carousel *is* the content, shipped as a PDF). Substack is reading-and-email — image-heavy emails render poorly and hurt deliverability, so keep it lean. Medium rewards a strong hero plus a few section images. Spec what does a job; don't decorate.

## Shared visual identity (state once, applies to every asset)

Open the artifact with one identity block so every image matches:

- **Tone matches the content's framing.** If the piece is evolutionary/positive, the visuals must be too — explicitly forbid warning aesthetics (red, cracks, alert icons) so nothing reads as ominous.
- **Background** — one consistent surface (e.g. warm neutral/cream).
- **One accent color**, reserved for the hero concept of the story; calm consistent neutrals for everything else.
- **Card style** — rounded cards, soft shadow; **labels in monospace SMALL CAPS** for a technical feel.
- **Byline** (bottom-right of each asset) — the author's name + tagline (carry the person's existing byline; ask if unknown).
- **Variants** — produce **light (default) + dark** versions of each image.
- **Clean and legible** — big type, generous whitespace, must survive being viewed tiny in a feed or email.
- **Asset naming** — number assets by section so they map to the post, e.g. `light-assets/0-hero.png`, `light-assets/1-...png`, with a matching `dark-assets/` set. archify renders land under the same names (`light-assets/<n>-<slug>.png`), with their source in `diagrams/<n>-<slug>/`.
- **archify diagrams keep archify's own palette and card style.** Don't ask the design tool to redraw them to match; match the hand-made assets (hero, decorative) to the same background family instead.

## Part A — Substack & Medium: one image per section

These two read as articles, so spec **one image per major section**, plus a shared hero. For each, give a **concise title** and a **concise description** (what to draw, the labels, which element takes the accent, the takeaway). Then decide **who renders it**: an archify type if the beat is diagram-shaped (see the type table in [archify.md](archify.md)), otherwise the design tool. Output as a table:

| # | Section | Title | Render | Description / files |
|---|---------|-------|--------|---------------------|
| 0 | Hero (1.91:1) | … | Claude Design | The whole thesis at a glance. Triples as Substack hero, Substack thumbnail, and the LinkedIn link-preview when cross-posted. |
| 1 | (first section) | … | archify `workflow` | ✅ rendered — `light-assets/1-….png` / `dark-assets/1-….png` · interactive `diagrams/1-…/1-….html` · caption: … |
| 2 | … | … | Claude Design | … |

For rows that archify rendered, the brief tells the design tool **not to redraw them**; they're final. For rows rendered by the design tool, keep the full description.

- The **hero is 1.91:1**; inline section images are **16:9**.
- At least one image should be a self-contained **"mental model" diagram** — the core idea drawn so it's screenshot-worthy on its own (that's how the piece gets pulled back onto LinkedIn/X by others). **Render it with archify** when available, and reuse the explore preview's `candidate.json` if one exists. For a contrast, render both states as the same diagram type with matching labels, plus one caption.
- Note placement: **Substack images are uploaded manually** at each section; **Medium images carry over** when the rendered HTML is copy-pasted (paths resolving next to the file).

## Part B — LinkedIn: slide-by-slide PDF brief

LinkedIn document posts are **PDFs**, so spec the carousel slide by slide:

- **Format** — portrait 4:5 (1080×1350) or square 1:1; one accent reserved for the story's hero element; build slides share a motif; the **turn/payoff slide breaks that rhythm**; readable on a phone.
- **Per slide** — give the slide's role (hook / build / insight / turn / mental-model / where-it-goes / CTA), the exact text, and a one-line visual direction.
- **Diagram slides come pre-rendered.** The mental-model slide, and any build slide that is really a flow or progression, are rendered by archify with the `slide` frame (4:5). Author them top-down so they fill the portrait frame, and reuse the same `candidate.json` as the article diagram where it fits. Mark those slides "archify — final, place as-is" with their PNG path. The design tool makes only the text and decorative slides.
- **Export** — assemble the slides and export as a single PDF for the document post.

## Always include a "what NOT to do" list

- Don't recycle the LinkedIn carousel slides into the Substack/Medium body — let each format stay native.
- Don't make the Substack post image-heavy (email rendering + deliverability).
- Don't use warning/error aesthetics for a positive-framed idea.
- Don't drift the running example — the same example shown in the post must appear in the visuals.
- Don't hand-redraw or restyle a diagram archify already rendered — edit its `candidate.json` and re-render instead.
- Don't use archify for the hero or for mood/metaphor art; it draws structure, not illustration.
