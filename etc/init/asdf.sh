#!/usr/bin/env bash

#git clone https://github.com/asdf-vm/asdf.git $HOME/.asdf --branch v0.14.1
#source $HOME/.asdf/asdf.sh

local plugins=(
  # github
  hub github-cli
  # tools
  fzf ghq delta bat jq
  # shell
  shellcheck shfmt
  # vim
  vim
)
for plugin in "${plugins[@]}"; do
  asdf plugin add $plugin
  asdf install $plugin latest
  asdf global $plugin latest
done
