#!/bin/bash

echo "Initialize Ruby"
if [[ ! -d ~/.rbenv ]]; then
  rbenv_home=${HOME}/.rbenv
  git clone https://github.com/rbenv/rbenv.git "${rbenv_home}"
  git clone https://github.com/rbenv/ruby-build.git "${rbenv_home}/plugins/ruby-build"
  git clone https://github.com/rkh/rbenv-update.git "${rbenv_home}/plugins/rbenv-update"
  git clone git://github.com/jf/rbenv-gemset.git "${rbenv_home}/plugins/rbenv-gemset"
  git clone git://github.com/momo-lab/rbenv-install-latest.git "${rbenv_home}/plugins/rbenv-install-latest"
  export PATH="${rbenv_home}/bin:$PATH"
  eval "$(rbenv init - --no-rehash zsh)"
  rbenv install-latest
fi
