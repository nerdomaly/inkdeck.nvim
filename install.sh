#!/usr/bin/env bash
# Installs inkdeck.nvim as your Neovim config by symlinking this repo
# into ~/.config/nvim. Any existing config is backed up, never deleted.
set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/nvim"

if [ -e "$CONFIG_DIR" ] || [ -L "$CONFIG_DIR" ]; then
  if [ -L "$CONFIG_DIR" ] && [ "$(readlink -f "$CONFIG_DIR")" = "$REPO_DIR" ]; then
    echo "inkdeck.nvim is already installed at $CONFIG_DIR"
    exit 0
  fi
  BACKUP_DIR="${CONFIG_DIR}.bak-$(date +%Y%m%d%H%M%S)"
  echo "Existing config found at $CONFIG_DIR, backing up to $BACKUP_DIR"
  mv "$CONFIG_DIR" "$BACKUP_DIR"
fi

mkdir -p "$(dirname "$CONFIG_DIR")"
ln -s "$REPO_DIR" "$CONFIG_DIR"
echo "Linked $CONFIG_DIR -> $REPO_DIR"
echo
echo "Next: launch 'nvim' and let lazy.nvim sync plugins on first start."
