#!/bin/bash

anyenv_root="${HOME}/.anyenv"
if [[ -d $anyenv_root ]]; then
  echo "anyenv is already installed."
else
  echo "anyenv install..."
  git clone https://github.com/anyenv/anyenv "${anyenv_root}"
  git clone https://github.com/momo-lab/anyenv-plugin.git "${anyenv_root}/plugins/anyenv-plugin"
  PATH=$PATH:${anyenv_root}/bin
  anyenv install --force-init

  # anyenv plugins
  anyenv plugin-install znz/anyenv-git
  anyenv plugin-install znz/anyenv-update
fi

# rbenv
if [[ -d ${anyenv_root}/envs/rbenv ]]; then
  echo "rbenv is already installed."
else
  echo "rbenv install..."
  anyenv install rbenv
  anyenv plugin-install jf/rbenv-gemset
  anyenv plugin-install rbenv momo-lab/xxenv-latest
fi

# pyenv
if [[ -d ${anyenv_root}/envs/pyenv ]]; then
  echo "pyenv is already installed."
else
  echo "pyenv install..."
  anyenv install pyenv
  anyenv plugin-install pyenv momo-lab/xxenv-latest
fi

# nodenv
if [[ -d ${anyenv_root}/envs/nodenv ]]; then
  echo "nodenv is already installed."
else
  echo "nodenv install..."
  anyenv install nodenv
  anyenv plugin-install nodenv momo-lab/xxenv-latest
fi

# goenv
if [[ -d ${anyenv_root}/envs/goenv ]]; then
  echo "goenv is already installed."
else
  echo "goenv install..."
  anyenv install goenv
  anyenv plugin-install goenv momo-lab/xxenv-latest
fi

anyenv init - --no-rehash > ~/.anyenv-rc.sh
