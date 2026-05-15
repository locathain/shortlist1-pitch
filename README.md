# Lua · Pitch Template

A GitHub **template repository** for spinning up password-protected, brand-styled, executive pitch decks for Lua AI Agent Framework prospects.

Every pitch built from this template gets:

- **Lua brand** — black canvas, Onest typeface, purple→magenta→red→orange gradient, animated identity
- **15-slide executive structure** + 6 architecture-deep-dive appendix slides
- **Three live animated slides** (conversational agent · background agent · data pipeline) with presenter-stepped builds
- **AES-256 password gate** via [staticrypt](https://github.com/robinmoisson/staticrypt) — branded auth page, no plaintext leakage
- **GitHub Pages-ready** — push and you have a shareable URL
- **Multi-channel / multi-modal framing** — voice, image, text · WhatsApp, Slack, web, email, custom
- **4-week proof-of-value sprint** as the default delivery shape
- **Fully mobile-responsive** — desktop / tablet / phone / tiny-phone breakpoints + landscape variant
- **Static mobile nav bar** — fixed `‹ Back / counter / Next ›` so presenters don't have to rely on swipe gestures
- **Mobile auto-scroll** — when an animated step reveals a new element on mobile, the page scrolls it into view automatically

---

## Quick start — new pitch in 5 minutes

```bash
# 1. Create a new repo from this template (requires gh CLI, authenticated)
gh repo create lua-ai-global/[client-slug]-pitch \
  --template lua-ai-global/pitch-template \
  --private \
  --clone

cd [client-slug]-pitch

# 2. Customize the source
#    Edit src/index.html — see docs/SLIDE_GUIDE.md for what to change
#    Replace every [CLIENT_NAME] · [CLIENT_CONTACT] · example data with reality

# 3. Encrypt and publish
./encrypt.sh                                # prompts for password
git add index.html && git commit -m "Initial pitch"
git push

# 4. Enable Pages (one-shot)
gh api -X POST "repos/lua-ai-global/[client-slug]-pitch/pages" \
  -f "source[branch]=main" -f "source[path]=/"

# 5. Done — your live URL:
#    https://lua-ai-global.github.io/[client-slug]-pitch/
```

For full step-by-step including making the pitch repo private and inviting reviewers, see [`docs/NEW_PITCH.md`](docs/NEW_PITCH.md).

You can also use the one-shot helper:

```bash
./scripts/new-pitch.sh [client-slug]
```

---

## What's in the box

| File | Purpose |
|---|---|
| `_template.html` | **Committed starter deck.** Shipped with the template so cloned pitches have a seed source. On first `./encrypt.sh` run, this is copied to `src/index.html`. Don't edit unless you're improving the template itself. |
| `src/index.html` | **Your editable source.** Bootstrapped from `_template.html` on first run. This is what you edit per-pitch. Encrypted at publish time. Gitignored — never commit it. |
| `index.html` | Encrypted output served by GitHub Pages. Produced by `encrypt.sh`. **Commit this.** |
| `staticrypt-template.html` | Lua-branded password gate. Don't edit unless changing the lock-screen brand. |
| `encrypt.sh` | Re-encrypt after edits. Prompts for password, never hardcodes it. Bootstraps `src/` from `_template.html` on first run. |
| `scripts/new-pitch.sh` | Bootstrap a new pitch repo from this template, end-to-end. |
| `logo.png` | The Lua mark — 512×512, white-on-transparent. Used on the cover, every slide header, and the auth gate. |
| `docs/BRAND.md` | Brand reference — colors, typography, gradients, voice. |
| `docs/SLIDE_GUIDE.md` | Slide-by-slide guide. What stays, what changes, narrative tips. |
| `docs/NEW_PITCH.md` | Step-by-step "creating your nth pitch" walkthrough. |

---

## Conventions

### Repo naming
Use the form `[client-slug]-pitch` (e.g. `madinet-masr-pitch`, `acme-corp-pitch`). The slug becomes the URL: `https://lua-ai-global.github.io/[slug]-pitch/`.

### Password choice
Use a strong, memorable phrase. Convention: `Lua{CLIENT}{YEAR}!@` — example: `LuaAcme2026!@`. Share the password with the client out-of-band (Signal, separate email, in person) — **never** in the same channel as the URL.

### Visibility
Keep new pitch repos **private** (org permits this on Team plan). The encrypted content on Pages is reachable anyone with the URL + password; the source repo is only for org members.

### History hygiene
After the very first push of a new pitch, **never** commit the unencrypted source. The `.gitignore` blocks `src/` — keep it that way. If you ever accidentally commit source, force-push a clean history immediately.

---

## How the password gate works

`staticrypt` wraps the deck content in AES-256 ciphertext and embeds a small JavaScript decryptor in `index.html`. When a visitor opens the URL:

1. They see the Lua-branded password prompt (see `staticrypt-template.html`)
2. They enter the password
3. JavaScript decrypts the deck client-side and renders it
4. With "remember me" checked, the browser holds the password for 30 days

It's genuinely secure — the unencrypted content is **never** sent over the wire. The trade-off: anyone with the password can save a copy after decrypting in their browser.

If you need stronger protection (revocation, audit logs), consider migrating to a hosted solution like Cloudflare Access — but for a pitch deck this is overkill.

---

## When NOT to use this template

- Public landing pages — staticrypt's password gate gets in the way
- Multi-author collaborative editing — single-file HTML doesn't scale well there; use Notion or Figma Slides
- Non-Lua brands — the visual identity is opinionated

For everything else (one-shot client pitches, executive briefs, board updates with confidential numbers), this template is the fastest path to a polished, password-protected, well-branded deliverable.

---

Built with the [Lua AI Agent Framework](https://docs.heylua.ai).
