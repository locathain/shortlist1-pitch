# Creating a new pitch — step by step

End-to-end walkthrough for spinning up a new client pitch from this template.

## Prerequisites

- `gh` CLI installed and authenticated (`gh auth status` should show you logged into github.com)
- Member of the `lua-ai-global` GitHub organization with create-repo permission
- A client slug in mind (lowercase, hyphenated — e.g. `acme-corp`)

## The fast path

```bash
./scripts/new-pitch.sh acme-corp
```

That script (run from a fresh clone of `lua-ai-global/pitch-template`) does everything below. If you need control over each step, do it manually:

## The manual path

### 1 · Create the repo

```bash
gh repo create lua-ai-global/acme-corp-pitch \
  --template lua-ai-global/pitch-template \
  --private \
  --clone

cd acme-corp-pitch
```

### 2 · Bootstrap your source file

The template ships `_template.html` at the root — the committed starter deck with `[CLIENT_NAME]` placeholders. On first run, `./encrypt.sh` copies it to `src/index.html` so you have an editable source. (`src/` itself is gitignored — `_template.html` is the committed seed.)

```bash
./encrypt.sh    # detects src/ missing, copies _template.html → src/index.html
                # then prompts for a password and encrypts
```

After this first run you only edit `src/index.html`. `_template.html` is reference-only; you don't need to touch it again.

### 3 · Customize the source

Open `src/index.html` in your editor and do a search-and-replace on every `[CLIENT_NAME]` and `[CLIENT_CONTACT]` placeholder. Then walk through `docs/SLIDE_GUIDE.md` for the slide-by-slide list of what else to customize.

The deck ships with Madinet Masr / Egyptian / Arabic example content as a worked reference — you'll want to swap the language, locations, names, numbers, regulators, and currency for your client's context.

### 4 · Encrypt and publish

```bash
./encrypt.sh
# Prompts for a password. Convention: Lua{CLIENT}{YEAR}!@
# e.g. LuaAcme2026!@
```

This regenerates `index.html` with the AES-256 encrypted payload.

```bash
git add index.html .staticrypt.json README.md
git commit -m "Initial encrypted pitch for Acme Corp"
git push
```

### 5 · Enable Pages

```bash
gh api -X POST "repos/lua-ai-global/acme-corp-pitch/pages" \
  -f "source[branch]=main" \
  -f "source[path]=/"
```

Wait ~30–60 seconds for the build:

```bash
gh api "repos/lua-ai-global/acme-corp-pitch/pages/builds/latest" --jq '.status'
# "building" → "built"
```

### 6 · Test

Visit `https://lua-ai-global.github.io/acme-corp-pitch/`. You should see the Lua-branded password gate. Enter the password — the deck unlocks.

**Test on mobile before sharing.** Open the URL on a phone (or Chrome DevTools device-emulation at ~390×844 for iPhone 14, ~360×640 for typical Android). Walk every slide. Confirm:

- Nothing overlaps horizontally — text wraps cleanly
- The `‹ Back / Next ›` nav bar at the bottom works on every slide
- On animated slides (6, 7, 8) tapping **Next** reveals the next build AND auto-scrolls it into view
- Architecture (slide 10) shows at small scale but fits — pinch-zoom for detail
- The cover meta-grid stacks correctly above the nav bar (no overlap)
- The footer chrome (`LUA · …`) is hidden on mobile; only the nav bar is visible

### 7 · Share with the client

- Send the URL via one channel (email)
- Send the password via a **different** channel (Signal, in-person, separate email)
- Never put both in the same message

### 8 · Iterate

For subsequent edits:

```bash
# 1. Edit src/index.html
# 2. Re-encrypt
./encrypt.sh
# 3. Push
git add index.html && git commit -m "Update X" && git push
# GitHub Pages rebuilds in ~30s automatically
```

---

## Common gotchas

- **`src/` accidentally committed:** force-purge history immediately. `git filter-repo --path src/ --invert-paths` then `git push --force`. The previous commits with plaintext content are now unreachable but were *briefly* visible. For maximum cleanup also rotate the password.
- **Password forgotten:** there is no recovery. Re-encrypt with a new password and republish; share the new one with the client.
- **Pages not building:** check `gh api repos/lua-ai-global/[client]-pitch/pages/builds/latest` for the build log. Most failures are markdown parsing errors that don't apply here (we're serving raw HTML).
- **Client wants to print:** the deck has print CSS — `Cmd+P` from inside the unlocked view. Each slide becomes a page.

---

## Decommissioning a pitch

When a client engagement ends and you want the deck offline:

```bash
# Option A — disable Pages, keep repo
gh api -X DELETE "repos/lua-ai-global/[client]-pitch/pages"

# Option B — archive the repo (recommended)
gh repo archive lua-ai-global/[client]-pitch
```

Archived repos are read-only and the Pages URL stops serving. The repo stays for reference.
