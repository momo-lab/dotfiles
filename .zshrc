basedir=$(dirname $(readlink -f $HOME/.zshrc))
for file in $(ls -1 $basedir/shell.d/*.{sh,zsh} 2> /dev/null); do
  source $file
done

### tmux起動
if [[ -x "$(which tmux 2> /dev/null)" && -z $TMUX ]]; then
  tmux -2 attach || tmux -2 new-session ; exit
fi

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_OPTS="--layout=reverse --height=30% --inline-info"
