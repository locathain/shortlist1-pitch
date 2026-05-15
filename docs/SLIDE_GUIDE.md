# Slide guide

Slide-by-slide walkthrough of the template — what stays, what you customize, and the narrative beat each slide is meant to land.

The deck is structured per Andy Raskin's strategic narrative + Kahneman's peak-end rule: the **prize** opens, the **live demos** are the peak (slides 6–8), the **ask** closes. Architecture detail is moved to an appendix accessed via the overview grid (`O` key).

---

## Main pitch (15 slides)

### 01 · Cover
- **Stays:** layout, brand row, four meta-grid pillars
- **Customize:** "Prepared for [CLIENT_CONTACT]" line; tagline ("One question. Every system. Trusted answers.") works for most pitches but adjust if the client's framing differs
- **Beat:** *who*, *for whom*, *outcome*

### 02 · ★ The North Star
- **Stays:** two-layer visual (Lua Agents above, Your AI-Ready Platform below)
- **Customize:** the example question (use a real cross-system question from the client's world); the localized version (Arabic/Spanish/etc.); the "receives" example outcome
- **Beat:** *the end state, in one image, in 30 seconds*

### 03 · Why this matters
- **Stays:** four-pillar grid structure with today/with-Lua/systems pattern
- **Customize:** the four pillars (use the client's actual strategic North Stars from their materials); systems pills; the example questions; the gradient colors per pillar
- **Beat:** *the client recognises themselves in our framing*

### 04 · The one blocker
- **Stays:** four KPI tiles + two-column "why it hasn't been solved" + their own quote
- **Customize:** the four numbers; the quote (from the client's own documents, not invented); the structural reasons
- **Beat:** *60 seconds. State the fact. Move on.*

### 05 · ★ What we're building
- **Stays:** four building blocks (One Lake · AI Mapping · Hybrid Retrieval · One Endpoint); each card framed as "Question · …"
- **Customize:** lightly — these four blocks apply to most data-and-agents pitches. Adjust the "Today" pain referenced if the client's situation is different
- **Beat:** *no vendor names. Plain English. Four boxes.*

### 06 · Live · conversational agent
- **Customize:** the user question (Arabic-first or local-first); the four tool-call signatures (use realistic data sources for this client); the final answer + citations
- **Beat:** *peak moment. Watch an executive ask, an agent answer.*

### 07 · Live · background agent
- **Customize:** the event trigger (pick something concrete from the client's flow — new customer, ticket created, invoice received); the agent name; the four tool calls; the verdict; the four actions taken
- **Beat:** *peak moment. Agents work while no one's looking.*

### 08 · Live · data pipeline
- **Customize:** the five station labels; the source-data card (use real-looking source records from the client's systems); the unified profile content
- **Beat:** *peak moment. From mess to trusted truth, in motion.*

### 09 · Why now
- **Customize:** lightly — the three "what shipped recently" cards (Profisee MDM, MCP gateway, GraphRAG) are Microsoft-current. Update them if you're presenting much later than 2026
- **Beat:** *this is buildable only because of recent shifts.*

### 10 · The architecture
- **Customize:** the source-systems row in the SVG (their actual stack); the agents row at the bottom
- **Beat:** *for the CIO. One canvas. Everything fits.*

### 11 · 4-week sprint
- **Stays:** the four-week structure
- **Customize:** week-by-week deliverables specific to the client's pillar / first agent / first systems
- **Beat:** *concrete plan. Demo at week 4.*

### 12 · The value
- **Customize:** the six value tiles (numbers in client's currency / language / context). Keep the structure
- **Beat:** *CFO view. Where the money lands.*

### 13 · Governance & risk
- **Customize:** lightly — Microsoft's reference patterns are constants. Adjust industry-alignment box if the client isn't real estate
- **Beat:** *for the CISO / compliance lead. Sign off on configuration, not custom build.*

### 14 · Assumptions
- **Customize:** the right column (Assumed) is the discovery agenda. Update with what you've assumed and need to validate with this specific client
- **Beat:** *transparency. Here's what we'd validate together.*

### 15 · Next steps
- **Stays:** three commitments (Discovery hour · 4-week sprint · Week 4 demo)
- **Customize:** the closing block (your contact details, the prepared-for line)
- **Beat:** *concrete ask. Three things, in order.*

---

## Architecture appendix (slides 16–21, on-demand)

These are accessed via the overview grid (`O` key). Walk through them only if the CIO or architecture lead asks.

- **16** · Sources & ingest
- **17** · Fabric medallion
- **18** · AI mapping
- **19** · Hybrid retrieval (Search + Graph)
- **20** · Agent gateway (Model Context Protocol)
- **21** · Agents on Lua

Most appendix slides are reusable as-is. The only one with frequent client-specific edits is **16 · Sources & ingest** — the system list needs to reflect the client's actual estate.

---

## Search-and-replace cheat sheet

When starting a new pitch from this template, run these search-replaces (or just do them as you go):

| Find | Replace with |
|---|---|
| `[CLIENT_NAME]` | The client's name |
| `[CLIENT_CONTACT]` | Your point of contact |
| `[client-slug]` | The lowercase-hyphenated slug used in URLs |
| `El Shorouk` | A representative location in the client's world |
| `Mohammed Ali` | A representative name in the client's world |
| `الشروق` / Arabic phrases | Local-language equivalent (Spanish, French, German…) |
| `Egyptian Pound (EGP)` / `EGP 12.4M` | Local currency |
| `Doors · CHUM · Theqa · Touba · SAFE · Finishing` | Client's subsidiary brand names |
| `FRA · PDPL · EGX · ESG · KYC · Carbon` | Client-region regulators |
| `Real Estate Development` | Client's industry vertical |
| `90,911 records` / `33,500` / `57,400` | Client's actual data-quality numbers |
| `31 systems` | Client's actual system count |

---

## Keyboard controls (when presenting)

| Key | Action |
|---|---|
| `→` `Space` | Next step (on animated slides) → next slide |
| `←` | Previous step → previous slide |
| `Home` / `End` | First / last slide |
| `1`–`9` | Jump to slide N |
| `O` | Overview grid (main pitch + appendix) |
| `F` | Fullscreen toggle |
| `P` | Print all slides |
| `?` | Keyboard help |
