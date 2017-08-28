basedir=$(dirname $(readlink -f $HOME/.bashrc))
for file in $basedir/shell.d/*.{sh,bash}; do
  if [ -f $file ]; then
    source $file
  fi
done
