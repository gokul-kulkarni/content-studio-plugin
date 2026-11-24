# Rendering diagrams with archify

This is the shared procedure every content-studio skill follows when a visual is **diagram-shaped**. Diagram-shaped means a progression, a process, a system, an interaction, a data flow, a set of states or a hierarchy. In those cases the skill renders the diagram with [archify](https://github.com/tt-a1i/archify) rather than only describing it. The hero image and purely decorative art stay with the design tool (Claude Design).

archify is **optional**. When it isn't installed, everything below falls back to the text-only brief in `design-brief`.

## 1. Detect

archify is available if either of these exists:

- `~/.claude/skills/archify/SKILL.md` (global install)
- `.claude/skills/archify/SKILL.md` (project install)

Call that folder `<archify>`. Its CLI is `node <archify>/bin/archify.mjs`. It also needs Node and Chrome/Chromium.

**If archify is not installed:**
1. Say so in one line.
2. Offer the install command. Run it only if the person says yes:
   ```bash
   npx -y skills@latest add https://archify.si --skill archify --agent claude-code --global --copy --yes
   ```
3. Otherwise continue with the text brief. Write the diagram rows as descriptions, exactly as before. Never block the pipeline on archify.

## 2. Let archify's own skill drive the authoring

Load the archify skill, read `<archify>/SKILL.md`, and follow its authoring steps (type router, schema, example, `finalize`, repair loop). **Do not copy or guess its JSON schemas.** They live in `<archify>/schemas/`, and archify's skill tells you which ones to read.

While archify is being used inside content-studio:

- **Native diagrams only.** Don't produce archify "explainer" pages, story videos or Code Analysis unless the person asks for one. Don't edit the person's global rules file to change archify's explainer mode.
- **Run each command once.** If `finalize` returns an `update` notice, mention it once at the end and never install updates on your own.
- **Keep `meta.evidence: "illustrative"`** for concept diagrams (most content). Use repository evidence (`--repo-root`) only when the diagram depicts a real codebase.

## 3. Pick the diagram type from the beat

| The beat is… | archify type |
|---|---|
| A history, progression or "every leap…" arc | `timeline` |
| A process, steps or a decision flow | `workflow` |
| A system, its components and how they connect | `architecture` |
| A request or interaction between actors over time | `sequence` |
| Data moving through stages | `dataflow` |
| States and the transitions between them | `lifecycle` |
| A taxonomy, hierarchy or "kinds of X" | `tree` |
| Tables and relationships | `erd` |
| Types and inheritance | `class` |
| Latency or timing breakdown | `waterfall` |
| A before/after contrast | two diagrams of the **same** type with the same layout. For architecture, use `archify compare architecture base.json head.json` |
| Not diagram-shaped (mood, metaphor, hero art) | leave it to the design tool |

**The mental-model diagram** (the screenshot-worthy one `design-brief` always asks for) is almost always one of `workflow`, `architecture`, `lifecycle` or `timeline`. Pick the one whose shape *is* the thesis.

## 4. Keep it on-message

- **Same running example.** Node labels, event titles and actors use the exact running example and terms from the locked master content, so the diagram and the prose match word for word.
- **Short labels.** They must survive at feed and email size. Put the explanation in the caption, not the boxes.
- **Tone.** archify colours by semantic `kind` (for example a timeline `alert` is red). For a positive or evolutionary framing, avoid alert/error/failure kinds and use neutral or "change"/"recovery"-style kinds, so nothing reads as a warning. This mirrors design-brief's "no warning aesthetics" rule.
- **One idea per diagram.** If a diagram needs a legend paragraph to make sense, split it or simplify it.
- **Portrait slides.** For a LinkedIn 4:5 slide, author a top-down layout (a vertical workflow, a tree or a narrow lifecycle). A wide left-to-right diagram leaves most of a portrait frame empty.

## 5. File layout

Everything sits next to the content files, numbered by section to match the existing `light-assets/` / `dark-assets/` naming:

```
diagrams/<n>-<slug>/candidate.json        ← the archify IR (source of truth; refine edits this)
diagrams/<n>-<slug>/<n>-<slug>.html       ← interactive standalone diagram (finalize output)
diagrams/<n>-<slug>/<n>-<slug>-light.svg  ← static exports
diagrams/<n>-<slug>/<n>-<slug>-dark.svg
light-assets/<n>-<slug>.png               ← upload-ready raster (light)
dark-assets/<n>-<slug>.png                ← upload-ready raster (dark)
```

Set `meta.output` in the candidate to `diagrams/<n>-<slug>/<n>-<slug>.html`. The explore preview uses `<n>` = `preview`.

## 6. Commands

Run these from the content folder. Use `<db>` for this skill's folder (the `design-brief` skill directory that contains this file).

```bash
ARCHIFY="node <archify>/bin/archify.mjs"
D=diagrams/<n>-<slug>

# 1) Validate + render + browser-check (fix failures via archify's repair loop)
$ARCHIFY finalize <type> $D/candidate.json $D/<n>-<slug>.html --quality showcase --json

# 2) Static SVGs, light + dark, straight from the candidate
$ARCHIFY export-svg <type> $D/candidate.json $D/<n>-<slug> --theme both --json

# 3) PNGs for upload (Substack, Medium and LinkedIn don't take SVG)
bash <db>/scripts/svg-to-png.sh $D/<n>-<slug>-light.svg light-assets/<n>-<slug>.png section
bash <db>/scripts/svg-to-png.sh $D/<n>-<slug>-dark.svg  dark-assets/<n>-<slug>.png  section
```

For the last argument of `svg-to-png.sh`, choose the frame by where the image goes:

| Destination | Frame | Size |
|---|---|---|
| Substack / Medium inline section image | `section` | 16:9, 1600×900 (@2x) |
| LinkedIn carousel slide | `slide` | 4:5, 1080×1350 (@2x) |
| Square post or thumbnail | `square` | 1:1 |
| Diagram's natural size | *(omit)* | intrinsic |

The script pads the diagram with archify's own background colour, so the frame looks seamless. The 1.91:1 hero is not rendered here; it stays in the design brief.

A non-zero exit from any command is a failure. Follow archify's repair guidance, re-run, and never report a diagram as done without a passing `finalize`.

## 7. Report back

For each rendered diagram, list:

- the section it belongs to
- the type
- the light and dark PNG paths
- the interactive HTML path
- a one-line caption (the takeaway)

The `design-brief` table and the `write-*` skills reference these paths, not descriptions.
