basedir=$(dirname $(readlink -f $HOME/.bashrc))
for file in $basedir/shell.d/*.{sh,bash}; do
  if [ -f $file ]; then
    source $file
  fi
done

if [ -f $HOME/.bashrc_local ]; then
  source $HOME/.bashrc_local
fi

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
