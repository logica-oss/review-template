#!/usr/bin/env bash
set -e

# Options from devcontainer-feature.json are exposed as env vars:
#   INSTALLPLAYWRIGHT, INSTALLFONTS
INSTALL_PLAYWRIGHT="${INSTALLPLAYWRIGHT:-true}"
INSTALL_FONTS="${INSTALLFONTS:-true}"

export DEBIAN_FRONTEND=noninteractive
export LANG=en_US.UTF-8

echo "Installing Re:VIEW toolchain..."

# --- base utilities (idempotent; base image already has most of these) ---
apt-get update
apt-get install -y --no-install-recommends \
  locales git curl ca-certificates \
  zip unzip \
  ghostscript gsfonts \
  poppler-data poppler-utils \
  mecab ruby-mecab mecab-ipadic-utf8 \
  plantuml \
  pandoc \
  ruby-dev build-essential pkg-config \
  ruby-zip ruby-nokogiri
apt-get clean
rm -rf /var/lib/apt/lists/*

# locale (needed for Japanese builds)
if ! locale -a 2> /dev/null | grep -qi "en_US.utf8"; then
  echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
  locale-gen en_US.UTF-8 || true
  update-locale en_US.UTF-8 || true
fi
mkdir -p /usr/share/man/man1

# --- TeXLive (Japanese) ---
# Same set as vvakame/docker-review (review-5.9/Dockerfile).
apt-get update
apt-get install -y --no-install-recommends \
  texlive-lang-japanese texlive-fonts-recommended texlive-latex-extra \
  lmodern fonts-lmodern cm-super tex-gyre fonts-texgyre \
  texlive-pictures texlive-plain-generic \
  texlive-luatex texlive-extra-utils
apt-get clean
rm -rf /var/lib/apt/lists/*

# Default to HaranoAji fonts (same as vvakame/review image)
if command -v kanji-config-updmap-sys > /dev/null 2>&1; then
  kanji-config-updmap-sys haranoaji || echo "warn: kanji-config-updmap-sys failed, continuing"
fi

# --- Ruby gems (global, same as vvakame/review image) ---
# NOTE: review gem version is managed by Gemfile (single source of truth).
gem install bundler -N

# --- Fonts + browser deps for Playwright / Vivliostyle ---
if [ "$INSTALL_FONTS" = "true" ]; then
  apt-get update
  apt-get install -y --no-install-recommends \
    fonts-noto-cjk-extra fonts-noto-color-emoji
  apt-get clean
  rm -rf /var/lib/apt/lists/*
fi

if [ "$INSTALL_PLAYWRIGHT" = "true" ]; then
  apt-get update
  apt-get install -y --no-install-recommends \
    libatk1.0-0 libatk-bridge2.0-0 libdrm2 libxkbcommon0 \
    libxcomposite1 libxdamage1 libxfixes3 libxrandr2 libgbm1 libpango-1.0-0
  apt-get clean
  rm -rf /var/lib/apt/lists/*

  if command -v bun > /dev/null 2>&1; then
    bun install -g playwright
    # Chromium only (same as vvakame/review: drop firefox/webkit to save ~350MB+)
    bunx --yes playwright install --with-deps chromium || bunx --yes playwright install chromium || true
  else
    echo "warn: bun not found (add Bun Feature before review Feature to enable 'bun install -g playwright'). Skipping playwright package."
  fi
fi

echo "Re:VIEW Feature install complete."
