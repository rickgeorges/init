#!/bin/bash
# Step 1: install Homebrew. Prompts once for your admin password.
set -euo pipefail

if ! command -v brew >/dev/null 2>&1; then
  NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

for b in /opt/homebrew/bin/brew /usr/local/bin/brew; do
  [ -x "$b" ] && eval "$("$b" shellenv)" && break
done

if ! grep -qs 'brew shellenv' "$HOME/.zprofile"; then
  echo "eval \"\$($(command -v brew) shellenv)\"" >> "$HOME/.zprofile"
fi

brew --version
