#!/bin/bash
# Step 2: install Podman and create/start its Linux VM.
# Do NOT use `brew services start podman`: it only runs the API socket, not the VM.
set -euo pipefail

BREW=""
for b in /opt/homebrew/bin/brew /usr/local/bin/brew; do
  [ -x "$b" ] && BREW="$b" && break
done
[ -n "$BREW" ] || { echo "brew not found; install Homebrew first" >&2; exit 1; }
eval "$("$BREW" shellenv)"

# Put brew (and podman) on PATH for future interactive shells.
LINE="eval \"\$($BREW shellenv)\""
grep -qsF "$LINE" "$HOME/.zprofile" || echo "$LINE" >> "$HOME/.zprofile"

brew install podman

if ! podman machine list --format '{{.Name}}' | grep -q .; then
  podman machine init --cpus 4 --memory 6144 --disk-size 60
fi

podman machine start 2>&1 || true
podman info >/dev/null
podman --version
podman machine list

