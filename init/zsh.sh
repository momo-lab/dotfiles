#!/bin/bash

echo "Initialize Zsh."
if which zsh 2>&1 > /dev/null; then
  zsh $HOME/.zshrc
  sudo chsh -s $(which zsh) $(id -un)
fi
