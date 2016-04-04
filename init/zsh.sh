#!/usr/bin/env zsh

PREZTODIR=${ZDOTDIR:-$HOME}/.zprezto
PREZTOURL=https://github.com/sorin-ionescu/prezto.git

if [[ -d $PREZTODIR ]]; then
    cd $PREZTODIR; git pull && git submodule update --init --recursive
else
    git clone --depth 1 --recursive $PREZTOURL $PREZTODIR
fi


setopt EXTENDED_GLOB
for rcfile in $PREZTODIR/runcoms/^README.md(.N); do
    ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
done

sudo chsh -s $(which zsh) $(id -un)
