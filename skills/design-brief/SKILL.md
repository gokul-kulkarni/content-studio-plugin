---
name: design-brief
description: "Design hand-off — after the content is locked, produce ONE artifact a design tool (e.g. Claude Design) can execute: a concise title + description for every section (inline images + a shared hero) for Substack and Medium, and a slide-by-slide PDF brief for LinkedIn. Use whenever someone wants graphics or visuals for their post, a carousel/PDF design spec, a hero/cover image, per-section images, asks 'should I make graphics for this?', or is handing content to a design tool and needs direction. Produces a brief, not the images themselves."
---

# Design Hand-off Brief

Write a precise, executable brief for the visuals supporting **$ARGUMENTS**, as a **single artifact** the person pastes straight into Claude Design (or any design tool). Output a spec another tool can follow — not the images.

Run this **after the content is locked** (Phase 3). If sections change later, this artifact is stale — regenerate it.

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
- **Asset naming** — number assets by section so they map to the post, e.g. `light-assets/0-hero.png`, `light-assets/1-...png`, with a matching `dark-assets/` set.

## Part A — Substack & Medium: one image per section

These two read as articles, so spec **one image per major section**, plus a shared hero. For each, give a **concise title** and a **concise description** (what to draw, the labels, which element takes the accent, the takeaway). Output as a table:

| # | Section | Title | Description |
|---|---------|-------|-------------|
| 0 | Hero (1.91:1) | … | The whole thesis at a glance. Triples as Substack hero, Substack thumbnail, and the LinkedIn link-preview when cross-posted. |
| 1 | (first section) | … | … |
| 2 | … | … | … |

- The **hero is 1.91:1**; inline section images are **16:9**.
- At least one image should be a self-contained **"mental model" diagram** — the core idea drawn so it's screenshot-worthy on its own (that's how the piece gets pulled back onto LinkedIn/X by others). For a contrast, spec both states being compared, the labels, and the caption.
- Note placement: **Substack images are uploaded manually** at each section; **Medium images carry over** when the rendered HTML is copy-pasted (paths resolving next to the file).

## Part B — LinkedIn: slide-by-slide PDF brief

LinkedIn document posts are **PDFs**, so spec the carousel slide by slide:

- **Format** — portrait 4:5 (1080×1350) or square 1:1; one accent reserved for the story's hero element; build slides share a motif; the **turn/payoff slide breaks that rhythm**; readable on a phone.
- **Per slide** — give the slide's role (hook / build / insight / turn / mental-model / where-it-goes / CTA), the exact text, and a one-line visual direction.
- **Export** — assemble the slides and export as a single PDF for the document post.

## Always include a "what NOT to do" list

- Don't recycle the LinkedIn carousel slides into the Substack/Medium body — let each format stay native.
- Don't make the Substack post image-heavy (email rendering + deliverability).
- Don't use warning/error aesthetics for a positive-framed idea.
- Don't drift the running example — the same example shown in the post must appear in the visuals.
