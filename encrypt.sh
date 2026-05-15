#!/bin/bash
# Re-encrypt the deck. Run after editing src/index.html.
# Password is prompted (never hardcode in repo).
set -e

# First-run bootstrap: if src/index.html doesn't exist but _template.html does,
# this is a fresh clone from the template — initialize src/ from the template.
if [ ! -f "src/index.html" ] && [ -f "_template.html" ]; then
  mkdir -p src
  cp _template.html src/index.html
  echo "✓ Bootstrapped src/index.html from _template.html (one-time setup)."
  echo "  Edit src/index.html, replacing [CLIENT_NAME] and [CLIENT_CONTACT]"
  echo "  with your client's details. See docs/SLIDE_GUIDE.md."
  echo ""
fi

if [ ! -f "src/index.html" ]; then
  echo "✗ src/index.html not found and no _template.html to bootstrap from."
  exit 1
fi

read -sp "Password: " PW
echo

npx --yes staticrypt src/index.html -p "$PW" --short --remember 30 -d . \
  -t staticrypt-template.html \
  --template-title 'Confidential pitch' \
  --template-instructions 'This deck is restricted to invited stakeholders. Enter the passcode shared with you to continue.' \
  --template-placeholder 'Passcode' \
  --template-button 'Unlock the deck' \
  --template-error 'Incorrect passcode — please try again.' \
  --template-remember 'Remember me on this device (30 days)'

echo "✓ index.html re-encrypted with brand template."
echo "  Next: git add index.html .staticrypt.json && git commit && git push"
