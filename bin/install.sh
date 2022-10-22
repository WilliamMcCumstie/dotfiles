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

# Symlink distro files into place
DISTRO="$(grep "^ID" /etc/os-release | cut -f2 -d=)"
DISTRO_ROOT="$ROOT/dist/$DISTRO"
for SRC in $(find "$DISTRO_ROOT" -type f); do
  DST=$(echo "$SRC" | sed "s#^$DISTRO_ROOT##")
  LNK="$ROOT/dist/.root$DST"

  if [ -e "$LNK" ]; then
    echo "Updating: $LNK"
  else
    echo "Creating: $LNK"
  fi
  mkdir -p $(dirname "$LNK")
  sudo cp -f "$SRC" "$LNK"
  sudo chown root:root "$LNK"

  if [ -e "$DST" ]; then
    echo "Skipping: $DST"
  else
    echo "Creating: $DST"
    mkdir -p $(dirname "$DST")
    sudo ln -s "$LNK" "$DST"
  fi
done
