#!/usr/bin/env bash

set -e

DOTFILES="$HOME/dotfiles"

echo "Installing dotfiles..."

link_file() {
  local source="$1"
  local target="$2"

  if [ -L "$target" ]; then
    echo "✓ Already linked: $target"
    return
  fi

  if [ -e "$target" ]; then
    echo "Backing up existing: $target -> $target.backup"
    mv "$target" "$target.backup"
  fi

  mkdir -p "$(dirname "$target")"
  ln -s "$source" "$target"

  echo "✓ Linked: $target"
}

link_dir() {
  local source="$1"
  local target="$2"

  if [ -L "$target" ]; then
    echo "✓ Already linked: $target"
    return
  fi

  if [ -e "$target" ]; then
    echo "Backing up existing: $target -> $target.backup"
    mv "$target" "$target.backup"
  fi

  mkdir -p "$(dirname "$target")"
  ln -s "$source" "$target"

  echo "✓ Linked: $target"
}

# Kitty
link_dir \
  "$DOTFILES/kitty" \
  "$HOME/.config/kitty"

# Neovim / LazyVim
link_dir \
  "$DOTFILES/nvim" \
  "$HOME/.config/nvim"

# Fastfetch
link_dir \
  "$DOTFILES/fastfetch" \
  "$HOME/.config/fastfetch"

# Starship
link_file \
  "$DOTFILES/starship/starship.toml" \
  "$HOME/.config/starship.toml"

# Zsh
link_file \
  "$DOTFILES/zsh/.zshrc" \
  "$HOME/.zshrc"

echo
echo "Done."
echo "Restart your terminal or run: exec zsh"
