### 自動コンパイル
# TODO: 速度が変わらなかったのでコメントアウトで残す
# # source command override technique
# function source {
#   ensure_zcompiled $1
#   builtin source $1
# }
# function ensure_zcompiled {
#   local compiled="$1.zwc"
#   if [[ ! -r "$compiled" || "$1" -nt "$compiled" ]]; then
#     echo "\033[1;36mCompiling\033[m $1"
#     zcompile $1
#   fi
# }
# ensure_zcompiled ~/.zshrc

### 各種設定を読み込み
basedir=$(dirname $(readlink -f $HOME/.zshrc))
for file in $(ls -1 $basedir/shell.d/*.{sh,zsh} 2> /dev/null); do
  source $file
done

if [[ -x "$(which tmux 2> /dev/null)" && -z $TMUX ]]; then
  ### tmux起動
  tmux -2 attach || tmux -2 new-session ; exit
fi
