#!/bin/bash
set -eu -o pipefail

# Docker entrypoint for TeX-less hosts:
#   install bun, install JS deps, then run the requested bun script (default: pdf).
# Usage: pdf:docker passes REVIEW_* env vars and an optional command.

if ! command -v bun > /dev/null 2>&1; then
  echo "Installing bun" >&2
  curl -fsSL https://bun.sh/install | bash
  export PATH="$HOME/.bun/bin:$PATH"
fi

cd /book
bun install

COMMAND="${1:-pdf}"
shift || true
exec bun run "$COMMAND" "$@"
