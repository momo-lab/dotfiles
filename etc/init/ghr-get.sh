#!/usr/bin/env bash

root=$HOME/.ghr-get
if [ ! -d $root ]; then
  git clone https://github.com/momo-lab/ghr-get $root
  export PATH=$root/bin:$PATH
  type ghr-get > /dev/null 2>&1 && eval "$(ghr-get init -)"
fi

# git subcommands
ghr-get install momo-lab/git-now

# bash plugins
ghr-get install momo-lab/bash-abbrev-alias

# zsh plugins
ghr-get install zsh-users/zsh-completions
ghr-get install zsh-users/zsh-history-substring-search
ghr-get install zsh-users/zsh-syntax-highlighting
#ghr-get install zsh-users/zsh-autosuggestions
ghr-get install momo-lab/zsh-abbrev-alias
ghr-get install momo-lab/zsh-replace-multiple-dots
ghr-get install momo-lab/zsh-smartinput
ghr-get install b4b4r07/enhancd
