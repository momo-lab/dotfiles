#!/bin/bash

WORKDIR=$(cd $(dirname $0) && pwd)

# initialize
dotfiles_initialize() {
    echo "Initialize."
    for file in $WORKDIR/init/*.sh; do
        $file
    done
}

# deploy
dotfiles_deploy() {
    echo "Deploy dotfiles."
    for file in $WORKDIR/.??*; do
        file=$(basename $file)
        [[ "$file" == ".git" ]] && continue

        ln -sfnv $WORKDIR/$file $HOME/$file
    done
}

# help
show_help() {
    echo "usage: $0 [command]" >&2
    echo "command" >&2
    echo "    init     deploy & initialize" >&2
    echo "    deploy   deploy only" >&2
}

if [[ "$1" == "" ]]; then
    show_help
    exit 1
fi
cmd=$1

case $cmd in
    "init")
        dotfiles_deploy
        dotfiles_initialize
        ;;
    "deploy")
        dotfiles_deploy
        ;;
    *)
        echo "unknown command $1." >&2
        show_help
        exit 1
esac

