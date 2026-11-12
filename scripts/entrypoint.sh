#!/bin/bash
set -eu -o pipefail

# Docker entrypoint for TeX-less hosts:
#   install bun, install JS deps, then run the requested bun script (default: pdf).
# Usage: pdf:docker passes REVIEW_CONFIG_FILE and an optional command.

# HOME and BUNDLE_PATH point to /tmp so non-root users can write caches.
export HOME="/tmp/home"
mkdir -p "$HOME"
export PATH="$HOME/.bun/bin:$PATH"
export BUNDLE_PATH="/tmp/home/bundle"

if ! command -v bun > /dev/null 2>&1; then
  echo "Installing bun" >&2
  curl -fsSL https://bun.sh/install | bash
fi

cd /book
bun install

COMMAND="${1:-pdf}"
shift || true
exec bun run "$COMMAND" "$@"
