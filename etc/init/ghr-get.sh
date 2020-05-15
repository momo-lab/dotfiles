#!/usr/bin/env bash

root=$HOME/.ghr-get
if [ ! -d $root ]; then
  git clone https://github.com/momo-lab/ghr-get.git $root
fi

ghr-get install junegunn/fzf-bin
ghr-get install monochromegane/the_platinum_searcher
ghr-get install github/hub
ghr-get install x-motemen/ghq
ghr-get install momo-lab/git-now
ghr-get install b4b4r07/ssh-keyreg
ghr-get install stedolan/jq
