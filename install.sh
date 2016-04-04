#!/bin/bash

# initialize
dotfiles_initialize() {
    echo "Initialize vim plugins."
    vim +PlugInstall +qall
}

# deploy
dotfiles_deploy() {
    echo "Deploy dotfiles."
    for file in .??*
    do
        [[ "$file" == ".git" ]] && continue

        ln -sfnv $(cd $(dirname $file) && pwd)/$(basename $file) $HOME/$file
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

