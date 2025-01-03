#!/bin/bash

echo "Initialize zsh."
if which zsh 2>&1 > /dev/null; then
  sudo chsh -s $(which zsh) $(id -un)
fi

echo "Install zsh plugins."
if !(which sheldon 2>&1 > /dev/null); then
  curl --proto '=https' -fLsS https://rossmacarthur.github.io/install/crate.sh \
      | bash -s -- --repo rossmacarthur/sheldon --to ~/.local/bin
fi
~/.local/bin/sheldon source > /dev/null
