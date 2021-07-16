#!/bin/bash

if [[ -d ~/.anyenv/bin ]]; then
  echo "anyenv is already installed."
else
  echo "anyenv install..."
  anyenv_root=${HOME}/.anyenv
  git clone https://github.com/anyenv/anyenv "${anyenv_root}"
  git clone https://github.com/momo-lab/anyenv-plugin.git "${anyenv_root}/plugins/anyenv-plugin"
  PATH=$PATH:${anyenv_root}/bin
  anyenv install --force-init

  # anyenv plugins
  anyenv plugin-install znz/anyenv-git
  anyenv plugin-install znz/anyenv-update
fi

# rbenv
if [[ -d ~/.anyenv/envs/rbenv ]]; then
  echo "rbenv is already installed."
else
  echo "rbenv install..."
  anyenv install rbenv
  anyenv plugin-install jf/rbenv-gemset
  anyenv plugin-install rbenv momo-lab/xxenv-latest
fi

# pyenv
if [[ -d ~/.anyenv/envs/pyenv ]]; then
  echo "pyenv is already installed."
else
  echo "pyenv install..."
  anyenv install pyenv
  anyenv plugin-install pyenv momo-lab/xxenv-latest
fi

# nodenv
if [[ -d ~/.anyenv/envs/nodenv ]]; then
  echo "nodenv is already installed."
else
  echo "nodenv install..."
  anyenv install nodenv
  anyenv plugin-install nodenv momo-lab/xxenv-latest
fi

# goenv
if [[ -d ~/.anyenv/envs/goenv ]]; then
  echo "goenv is already installed."
else
  echo "goenv install..."
  anyenv install goenv
  anyenv plugin-install goenv momo-lab/xxenv-latest
fi

anyenv init - --no-rehash > ~/.anyenv-rc.sh
