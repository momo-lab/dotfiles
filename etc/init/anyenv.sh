#!/bin/bash

echo "Initialize anyenv"
if [[ ! -d ~/.anyenv/bin ]]; then
  anyenv_root=${HOME}/.anyenv
  git clone https://github.com/anyenv/anyenv "${anyenv_root}"
  git clone https://github.com/momo-lab/anyenv-plugin.git "${anyenv_root}/plugins/anyenv-plugin"
  ${anyenv_root}/bin/anyenv install --init

  # anyenv plugins
  anyenv plugin-install znz/anyenv-git
  anyenv plugin-install znz/anyenv-update

  # install *env
  anyenv install rbenv
  anyenv install pyenv
  eval "$(anyenv init -)"

  # rbenv
  anyenv plugin-install jf/rbenv-gemset
  anyenv plugin-install rbenv momo-lab/xxenv-latest

  # pyenv
  anyenv plugin-install pyenv momo-lab/xxenv-latest
fi
