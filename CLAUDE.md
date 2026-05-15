# CLAUDE.md — instructions for Claude Code working on a Lua pitch

You are helping a Lua AI Agent Framework team member build or refine an executive pitch deck for a prospective client. This repo was scaffolded from `lua-ai-global/pitch-template`. Read this entire file before doing anything else; it contains the non-negotiable conventions you must follow.

---

## What this project IS

A **single-file HTML presentation deck**, password-protected with [staticrypt](https://github.com/robinmoisson/staticrypt), deployed via GitHub Pages.

- **Source of truth:** `src/index.html` (gitignored — local-only).
- **Deployed artefact:** `index.html` at root — AES-256 encrypted. **Commit this.**
- **Brand-styled password gate:** `staticrypt-template.html`.
- **Re-encrypt:** `./encrypt.sh` (prompts for password — never hardcode).
- **Template seed:** `_template.html` is the committed starter source. On first run, `encrypt.sh` copies it to `src/index.html` so the editor has something to work with. After that, you only edit `src/index.html`; `_template.html` is reference-only.

The user is almost certainly here to (a) customize the deck for a specific client, (b) refine narrative/visuals, or (c) publish/republish. Match their intent.

---

## The single most important principle: TWO LAYERS

The deck describes **two distinct layers** and you must never conflate them in copy or visuals:

1. **Your AI-Ready Data Platform** — the unified lake, AI mapping, hybrid retrieval, and agent gateway. **The client owns this.** Lua *helps them build it on Microsoft Azure.*
2. **Lua Agents** — the agent layer that sits on top, consumes the gateway, and answers questions. **Lua delivers this.**

**Never** describe the data platform as "the Lua platform" or imply Lua owns/runs the infrastructure. The client is the owner. We help them stand it up, then we build agents on top.

Watch for and fix any phrasing like:
- ❌ "the Lua platform unifies your systems"
- ✅ "your AI-ready platform unifies your systems · Lua agents answer the questions"

---

## Voice & tone rules

- **Direct, executive register.** Avoid hedges ("might", "could", "we believe"). State things.
- **Plain English by default.** Expand all acronyms on first use:
  - MDM → Master Data Management
  - KYC → customer due-diligence
  - MCP → agent gateway (mention "Model Context Protocol" once in the appendix)
  - AML/PEP → anti-money-laundering · politically-exposed-persons
  - HSE → Health, Safety & Environment
  - KSA → Saudi Arabia · MENA → Middle East · GCC → Gulf
  - PDPL → Personal Data Protection Law · FRA → Financial Regulatory Authority · EGX → Egyptian Exchange
  - CDC → live sync · OBO → on-behalf-of · CMK → customer-managed keys · ACL → permission-trimming
  - SHIR → self-hosted integration runtime · iPaaS → integration platform
  - GA → "Live" (Microsoft's "general availability" reads as jargon)
- **Keep universal abbreviations:** CEO/CFO/CIO/CRM/ERP/BI/AI/IT/SLA/KPI/ROI/API.
- **Em-dashes for pace.** Use `—` (not `--`).
- **Local-first for spoken queries.** Voice-via-WhatsApp examples must show the client's local language first, English subtitle below. For Egyptian clients use **Egyptian Arabic dialect** (Masri — إيه, اللي, اتأخرت, أكتر), NOT Modern Standard Arabic, since the framing is *spoken*.
- **4-week sprint** is the canonical delivery shape. Avoid 18-month, 40-week, "production roadmap" framing — those were deliberately stripped from the brand narrative.
- **Numbers as proof.** "33,500 broken records" beats "many broken records". Always prefer specific.

---

## The deck structure (don't break it)

### Main pitch — 15 slides

01. Cover · 02. North Star · 03. Why this matters · 04. The one blocker · 05. What we're building · 06. Live conversational agent · 07. Live background agent · 08. Live data pipeline · 09. Why now · 10. Architecture · 11. 4-week sprint · 12. Value · 13. Governance · 14. Assumptions · 15. Next steps

### Architecture appendix — 6 slides (accessed via `O` overview)

16. Sources & ingest · 17. Fabric medallion · 18. AI mapping · 19. Hybrid retrieval · 20. Agent gateway · 21. Lua agents

The **animations are at slides 6–8** by design (Kahneman's peak-end rule — strongest moment in the middle, concrete ask at the end). Don't move them.

If asked to add slides, ask whether they're main-flow (insert before slide 15 and renumber) or appendix (insert at end with `data-appendix="true"`).

For deeper guidance on what to customize per slide vs. what stays, read `docs/SLIDE_GUIDE.md` before answering slide-content questions.

---

## Brand tokens (do not invent new ones)

All defined as CSS custom properties in `src/index.html` `:root`. Use these — never hardcode hex values.

- Gradient: `var(--grad)` — `linear-gradient(90deg, #995FF8, #F633A2, #FF0342, #FF8A00)`
- Magenta accent: `var(--magenta)` (`#F633A2`)
- Surfaces: `var(--surface)`, `var(--surface-2)` (dark cards)
- Text: `var(--text)` / `var(--text-2)` / `var(--text-3)` / `var(--text-muted)`
- Status: `var(--ok)` (success) · `var(--critical)` (error/red)

Full reference: `docs/BRAND.md`.

Typography is **Onest** for everything except mono (JetBrains Mono). Never introduce a third typeface.

---

## Animation system — step-based, presenter-driven

The three animated slides (`scene`, `bg-scene`, `pipeline`) use `data-steps="N"` on the parent and `data-stage="N"` on each child build. JS toggles `.on` / `.active` / `.passed` classes based on the current step. The presenter advances each build with `→` / Space (or the mobile `Next ›` button).

When asked to add or modify an animated reveal:
1. Add `data-stage="N"` to the element being revealed.
2. Increment the parent's `data-steps` count.
3. Update the `.step-progress` indicator (add a `.sp-dot`).
4. CSS reveals are based on `.on` class — animations only fire when added, so each press feels crisp.

Don't use `animation-delay` for staged reveals (the original code used to — it was refactored to class-based for presenter control). The animation reset is centralized in `applyStage()` in the slide-deck JS.

**Mobile auto-scroll** is built in: when `next()`/`prev()` advance a step on an animated slide AND the viewport is ≤900px, the newly-active stage element is scrolled into the center of the viewport with `scrollIntoView({behavior:'smooth', block:'center'})`. See `scrollStageIntoView()` in the script. If you add a new animated slide, this works automatically as long as the new builds use the `data-stage` attribute.

---

## Mobile responsiveness

The deck is fully responsive across desktop, tablet (≤900px), phone (≤600px), and tiny phones (≤380px), with a landscape-phone variant for short viewports.

**What changes on mobile:**

- **Static nav bar at bottom** — fixed `‹ Back / counter / Next ›` bar replaces the desktop "swipe / arrow keys" affordance. The `<div class="mobile-nav">` lives outside the deck container and is shown only at ≤900px via CSS.
- **Chrome hidden** on mobile (the nav bar takes its role).
- **Multi-column grids collapse** — 4-col North-Star pillars → 1-col on phone (KPIs stay 2-col so the four numbers stay scannable).
- **Type scale rescales** — h1 from 128→32px, h2 64→22px, KPI numbers 68→38px.
- **Animated pipeline stations stack vertically** — the horizontal rail hides on mobile; each station+card becomes a row.
- **Architecture SVG scales 100% width** — no horizontal scroll; pinch-zoom for detail.
- **Background-agent scene** drops grid layout and uses flex column to avoid implicit-column collisions.
- **All `flex:1` scene containers reset to `flex:initial` on mobile** so content takes natural height and the slide scrolls.
- **Force cards, phase cards** get `height:auto + overflow:visible` (desktop's `height:100%` truncates text on mobile).
- **Inline `display:flex` panels (medallion, agents footer)** force column-stack on mobile via an attribute selector — don't introduce new inline flex panels, prefer a `.panel-row` class.

**When testing mobile:** open the live URL on a phone, or use Chrome DevTools device emulation. Walk every slide. Look specifically for:
- Text overflowing horizontally (should never happen — `overflow-x:hidden` + `word-break` on every prose element)
- Cards or pills overlapping each other
- The mobile nav bar covering content (every slide has `padding-bottom: 88px` to clear it)
- Animated slides: tap Next, confirm each new stage scrolls into view

**If you find an overlap:** the defensive layer near the end of the `<style>` block runs LAST in the cascade. Add a targeted `!important` rule there rather than hunting through earlier breakpoints.

---

## Workflow

### Editing the deck

1. Edit `src/index.html` (this stays local — gitignored).
2. Run `./encrypt.sh` — prompts for the same password the client has.
3. `git add index.html .staticrypt.json && git commit && git push`.
4. GitHub Pages rebuilds in ~30s.

### Things that must never happen

- ❌ **Committing `src/index.html`** — it's plaintext. The `.gitignore` blocks it; if the user asks you to commit it, refuse and explain.
- ❌ **Hardcoding the password** anywhere in the repo (encrypt.sh, README, source). It's prompted at encrypt time and shared out-of-band.
- ❌ **Pushing while the password file** (`src/index.html`) is in the staging area — `git status` first, always.
- ❌ **Editing `index.html` directly** — it's the encrypted output. Edit `src/index.html` and re-encrypt.

### Creating a new pitch from scratch (if the user is in the template repo)

If you find yourself in `lua-ai-global/pitch-template` and the user asks you to start a new client pitch, point them to `./scripts/new-pitch.sh <client-slug>` rather than copying files manually.

---

## Common requests — how to handle them

| The user asks… | You do… |
|---|---|
| "Customize this for [Client]" | Find every `[CLIENT_NAME]` / `[CLIENT_CONTACT]` placeholder in `src/index.html`. Then walk `docs/SLIDE_GUIDE.md` and offer to update slide-by-slide. Always ask before fabricating client-specific numbers; if you don't know their data, leave placeholders. |
| "Add a slide about X" | Ask: main-flow or appendix? Then duplicate the closest-matching existing slide pattern and update content. Renumber `data-title` and `section-num` consistently. |
| "Make this animation step through clicks" | Convert any `animation: …Ns forwards` to `.on`-class-triggered reveals (see Animation section above). |
| "Change the brand color" | Push back — the brand is fixed. If they insist, only change CSS variables in `:root`, never inline hexes. |
| "Make this readable to a CFO" | Apply the abbreviation-expansion rules + numeric proof points + 4-week framing. |
| "Publish this" | Verify `src/index.html` is current → `./encrypt.sh` → commit `index.html` + `.staticrypt.json` only → push → confirm Pages built. |
| "I forgot the password" | There's no recovery. Re-encrypt with a new password and republish — and tell them to rotate with the client. |
| "How do I share this?" | URL + password through **different** channels (Signal for password, email for URL). |

---

## Things to never do

- Don't invent client-specific numbers, names, or quotes. If the data isn't in the user's materials, leave a `[TODO]` and ask.
- Don't conflate the data platform (theirs) with Lua agents (ours). See "Two Layers" above.
- Don't introduce new acronyms without expanding them.
- Don't move the animations away from slides 6–8.
- Don't suggest backwards-compatibility shims, feature flags, or "make it configurable" — this is a static pitch deck, not a product.
- Don't write multi-paragraph code comments. The HTML is already self-documenting through structure.
- Don't add npm dependencies. The deck is intentionally a single HTML file plus staticrypt (already invoked via `npx`).
- Don't suggest moving off GitHub Pages. The current stack is deliberate: free, fast, owned.

---

## Files & where things live

```
.
├── CLAUDE.md                   ← you are here
├── README.md                   ← high-level quick start
├── docs/
│   ├── BRAND.md                ← colors, typography, voice
│   ├── SLIDE_GUIDE.md          ← slide-by-slide narrative + customization checklist
│   └── NEW_PITCH.md            ← detailed walkthrough for new pitches
├── src/index.html              ← SOURCE deck (gitignored)
├── index.html                  ← encrypted output (deployed)
├── staticrypt-template.html    ← brand-styled password gate
├── logo.png                    ← Lua mark (512×512 white-on-transparent)
├── encrypt.sh                  ← re-encrypt helper
├── scripts/new-pitch.sh        ← bootstrap a new client repo
├── .staticrypt.json            ← salt for encryption (safe to commit)
└── .gitignore                  ← blocks src/, node_modules/, IDE files
```

---

## Quick reference: live commands

```bash
# Re-encrypt after editing src/index.html
./encrypt.sh

# Commit encrypted output (NEVER commit src/index.html)
git add index.html .staticrypt.json
git commit -m "…"
git push

# Check live URL
echo "https://lua-ai-global.github.io/$(basename "$(pwd)")/"

# Check Pages build
gh api "repos/lua-ai-global/$(basename "$(pwd)")/pages/builds/latest" --jq '.status'

# Bootstrap a totally new pitch (only relevant in pitch-template repo)
./scripts/new-pitch.sh <client-slug>
```

---

## When you're unsure

Ask. The user is an executive presenter — they value precision over volume. A short clarifying question is better than fabricated content that they'll have to undo.
