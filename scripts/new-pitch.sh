#!/bin/bash
# new-pitch.sh — bootstrap a new client pitch from this template.
#
# Usage:
#   ./scripts/new-pitch.sh <client-slug>
#
# Example:
#   ./scripts/new-pitch.sh acme-corp
#
# What it does:
#   1. Creates lua-ai-global/<slug>-pitch from this template repo (private)
#   2. Clones it to ../[slug]-pitch
#   3. Prompts you for a password
#   4. Encrypts a placeholder index.html so Pages has something to serve
#   5. Pushes the initial commit
#   6. Enables GitHub Pages
#   7. Prints the live URL for you to share once you've customized the deck

set -e

SLUG=$1
if [ -z "$SLUG" ]; then
  echo "Usage: $0 <client-slug>"
  echo "Example: $0 acme-corp"
  exit 1
fi

# Validate slug — lowercase, hyphens, alphanumeric
if [[ ! "$SLUG" =~ ^[a-z0-9][a-z0-9-]+[a-z0-9]$ ]]; then
  echo "✗ Slug must be lowercase letters, numbers, and hyphens only (e.g. acme-corp)"
  exit 1
fi

REPO="lua-ai-global/${SLUG}-pitch"
TARGET_DIR="../${SLUG}-pitch"

echo "═══════════════════════════════════════════════════════════"
echo "  Creating pitch: $REPO"
echo "═══════════════════════════════════════════════════════════"

# Check gh auth
if ! gh auth status &>/dev/null; then
  echo "✗ gh CLI not authenticated. Run: gh auth login"
  exit 1
fi

# 1. Create repo from template
echo ""
echo "→ Creating repo from template…"
gh repo create "$REPO" \
  --template "lua-ai-global/pitch-template" \
  --private \
  --clone \
  --description "Confidential pitch — Lua AI Agent platform for $SLUG"

# Move into the new clone
NEW_DIR=$(basename "$REPO")
cd "$NEW_DIR"

# 2. Prompt for password and encrypt
echo ""
echo "→ Choose a password for this pitch (convention: Lua${SLUG^}${YEAR}!@)"
./encrypt.sh

# 3. Commit and push the initial encrypted version
echo ""
echo "→ Committing initial encrypted deck…"
git add index.html .staticrypt.json
git -c commit.gpgsign=false commit -m "Initial encrypted pitch for ${SLUG}"
git push

# 4. Enable Pages
echo ""
echo "→ Enabling GitHub Pages…"
gh api -X POST "repos/${REPO}/pages" \
  -f "source[branch]=main" \
  -f "source[path]=/" \
  --silent 2>&1 || echo "  (Pages may already be enabled)"

# 5. Wait for build
echo "→ Waiting for first Pages build…"
until gh api "repos/${REPO}/pages/builds/latest" 2>/dev/null | grep -q '"status":"built"'; do
  sleep 5
  echo -n "."
done
echo " ✓ built"

# Final output
URL="https://lua-ai-global.github.io/${SLUG}-pitch/"
echo ""
echo "═══════════════════════════════════════════════════════════"
echo "  ✓ Done."
echo "═══════════════════════════════════════════════════════════"
echo ""
echo "  Live URL:  $URL"
echo "  Repo:      https://github.com/${REPO}"
echo "  Local:     $(pwd)"
echo ""
echo "  Next:"
echo "    1. Edit src/index.html — see docs/SLIDE_GUIDE.md"
echo "    2. Run ./encrypt.sh after each edit batch"
echo "    3. git add index.html && git commit -m '…' && git push"
echo ""
echo "  Share the URL and password with the client through"
echo "  DIFFERENT channels (URL by email, password by Signal)."
echo ""
