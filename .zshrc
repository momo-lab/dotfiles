basedir=$(dirname $(readlink -f $HOME/.zshrc))
for file in $basedir/shell.d/*.{sh,zsh}; do
  source $file
done

### tmux起動
if [[ -x "$(which tmux 2> /dev/null)" && -z $TMUX ]]; then
  tmux -2 attach || tmux -2 new-session ; exit
fi
