#!/bin/bash

echo "Initialize anyenv"
if [[ ! -d ~/.anyenv/bin ]]; then
  anyenv_root=${HOME}/.anyenv
  git clone https://github.com/riywo/anyenv "${anyenv_root}"
  git clone https://github.com/momo-lab/anyenv-plugin.git "${anyenv_root}/plugins/anyenv-plugin"
  export PATH="${anyenv_root}/bin:$PATH"
  eval "$(anyenv init -)"

  # anyenv plugins
  anyenv plugin-install znz/anyenv-git
  anyenv plugin-install znz/anyenv-update

  # rbenv
  anyenv install rbenv
  eval "$(anyenv init -)"
  anyenv plugin-install jf/rbenv-gemset
  anyenv plugin-install momo-lab/rbenv-install-latest
fi
