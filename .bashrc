basedir=$(dirname $(readlink -f $HOME/.bashrc))
for file in $basedir/shell.d/*.{sh,bash}; do
  source $file
done
