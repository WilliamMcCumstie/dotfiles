#!/bin/bash

ROOT=$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." && pwd )
XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
mkdir -p "$XDG_DATA_HOME"
XDG_LIBEXEC_HOME="${XDG_LIBEXEC_HOME:-"$(cd "$XDG_DATA_HOME/.." && pwd)/libexec"}"

# Installing nvim
NVIM_SRC="$ROOT/nvim/init.vim"
NVIM_DST="$XDG_CONFIG_HOME/nvim/init.vim"
if [ -e "$NVIM_DST" ]; then
  echo "Skipping: $NVIM_DST"
else
  echo "Creating: $NVIM_DST"
  mkdir -p $(dirname "$NVIM_DST")
  ln -s "$NVIM_SRC" "$NVIM_DST"
fi

# Installing zshrc
ZSHRC_SRC="$ROOT/zsh/.zshrc"
ZSHRC_DST="$HOME/.zshrc"
if [ -e "$ZSHRC_DST" ]; then
  echo "Skipping: $ZSHRC_DST"
else
  echo "Creating: $ZSHRC_DST"
  ln -s "$ZSHRC_SRC" "$ZSHRC_DST"
fi

# Installing sway
SWAY_SRC="$ROOT/sway/config"
SWAY_DST="$XDG_CONFIG_HOME/sway/config"
if [ -e "$SWAY_DST" ]; then
  echo "Skipping: $SWAY_DST"
else
  echo "Creating: $SWAY_DST"
  mkdir -p $(dirname "$SWAY_DST")
  ln -s "$SWAY_SRC" "$SWAY_DST"
fi


SWAY_LIBEXEC_SRC="$ROOT/sway/libexec"
SWAY_LIBEXEC_DST="$XDG_LIBEXEC_HOME/sway"
if [ -e "$SWAY_LIBEXEC_DST" ]; then
  echo "Skipping: $SWAY_LIBEXEC_DST"
else
  echo "Creating: $SWAY_LIBEXEC_DST"
  mkdir -p $(dirname "$SWAY_LIBEXEC_DST")
  mkdir -p $(dirname "$SWAY_LIBEXEC_DST")
  ln -s "$SWAY_LIBEXEC_SRC" "$SWAY_LIBEXEC_DST"
fi

