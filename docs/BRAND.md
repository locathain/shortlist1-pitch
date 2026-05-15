# Lua · Brand reference

Source: Lua Brand Design Figma file (node 27:16). All colors and typography here mirror what's hardcoded in `src/index.html` — change here AND there if you ever rebrand.

## Logo

- File: `logo.png` (512×512, white on transparent)
- Original Figma node: `27:21` ("LUA noBG (1) 1")
- Usage:
  - **Cover slide hero:** large, centered with the brand-row label
  - **Slide headers:** 20px chip
  - **Chrome (bottom bar):** 18px
  - **North Star centerpiece:** 34px with brand-magenta drop-shadow glow
  - **Auth gate:** 42px with brand-magenta drop-shadow glow

Never colorize the logo. Always white on a dark surface. If you ever need it on a light background, request a dark version from design.

## Typography

- **Display & body:** [Onest](https://fonts.google.com/specimen/Onest) — weights 300, 400, 500, 600, 700, 800
- **Monospace:** [JetBrains Mono](https://fonts.google.com/specimen/JetBrains+Mono) — weights 400, 500, 600
- Both Google Fonts, loaded via CDN preconnect

**Type scale** (in `src/index.html` `:root`):

| Element | Size | Weight | Letter-spacing |
|---|---|---|---|
| h1 (cover) | `clamp(56px, 8vw, 128px)` | 700 | -.038em |
| h2 (slide headline) | `clamp(36px, 4.4vw, 64px)` | 600 | -.028em |
| h3 | `clamp(22px, 2.2vw, 32px)` | 600 | -.018em |
| h4 | `clamp(17px, 1.4vw, 22px)` | 600 | -.012em |
| Body (`p`) | `clamp(14px, 1.02vw, 17px)` | 400 | normal |
| Eyebrow | 11px | 600 | .22em |

Negative tracking on large heads is intentional — Onest reads tight at scale.

## Colors

```css
/* Brand gradient — purple → magenta → red → orange */
--grad: linear-gradient(90deg, #995FF8 0%, #F633A2 30%, #FF0342 60%, #FF8A00 100%);

/* Brand accents */
--purple:  #995FF8
--magenta: #F633A2   /* primary accent — eyebrows, borders, hover states */
--red:     #FF0342
--orange:  #FF8A00
--cream:   #FFC474

/* Neutrals */
--bg:       #000000  /* canvas */
--bg-1:     #0A0A0E  /* darker side rail */
--bg-2:     #14141A  /* card recess */
--surface:  #16161E  /* default card */
--surface-2:#1F1F2A  /* elevated card */
--surface-3:#2A2A38  /* highest elevation */

/* Borders */
--border:        rgba(255,255,255,0.08)
--border-2:      rgba(255,255,255,0.14)
--border-brand:  rgba(246,51,162,0.40)

/* Text */
--text:        #FFFFFF
--text-2:      rgba(255,255,255,0.80)   /* secondary copy */
--text-3:      rgba(255,255,255,0.58)   /* tertiary, captions */
--text-muted:  rgba(255,255,255,0.40)   /* labels, metadata */

/* Status */
--ok:        #00C896   /* success, "passed" stages */
--critical:  #FF0342   /* error, "broken records" KPIs */
```

## Gradient usage

**The brand gradient is the single most recognisable element.** Use it on:

- Display headlines — apply `.grad-text` class to emphasized words (typically the second half of a 2-part headline)
- Section dividers — `.grad-line` (a 64×2px gradient bar replacing the standard `<hr>`)
- Card top edges — a 2px gradient bar on `.panel.brand`, `.value`, `.force`, etc.
- Buttons / CTAs — the auth gate's unlock button, action panels
- The logo's drop-shadow glow

**Don't** use the gradient as a background fill — only as accents, edges, and text-clipping.

## Voice & tone

- **Direct, executive.** Avoid hedging ("might", "could", "we believe").
- **Plain English by default.** Expand acronyms on first use (Master Data Management, not MDM). The audience is CEO/CFO/CIO — they shouldn't have to translate jargon as they read.
- **Em-dashes for pace.** Use `—` to break thought, never `--` or `-- `.
- **Numbers as proof.** "33,500 broken records" beats "many broken records".
- **The two-layer principle.** Always distinguish: *your* AI-ready data platform (what we help you build) vs. *Lua* agents (what we deliver). Never conflate as "the Lua platform".
- **Arabic-first / local-first** for any spoken-query examples. Show the local language first, English subtitle below — demonstrates the agent understands how people actually speak.
- **4-week sprint.** Reference timelines should align to this. Avoid 18-month and 40-week framing — those have been deliberately removed from the brand narrative.

## Animations

The deck has three step-animated slides — each uses the same data-stage pattern:

```html
<div class="scene" data-steps="4" data-step="1">
  <div class="step-progress">…</div>
  <div data-stage="1">…</div>
  <div data-stage="2">…</div>
  …
</div>
```

JS toggles `.on`, `.active`, `.passed` classes on `[data-stage]` elements as the presenter advances. CSS animations trigger when `.on` is added, so each step reveal is crisp on every press. The presenter advances with `→` / `Space`; once the last stage is shown, the next press moves to the next slide.

See `src/index.html` `applyStage()` function for the mechanism.
