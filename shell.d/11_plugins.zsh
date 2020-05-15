# Clone zplug if not found
export ZPLUG_HOME=~/.zplug
[[ ! -d ${ZPLUG_HOME} ]] && { git clone https://github.com/zplug/zplug $ZPLUG_HOME }
source ${ZPLUG_HOME}/init.zsh

# 入力した文字の色を変える
zplug "zsh-users/zsh-syntax-highlighting"
# up/downで履歴選択時、入力済みの内容にマッチする履歴を選ぶようにする
zplug "zsh-users/zsh-history-substring-search"
# 入力補完
zplug "zsh-users/zsh-completions"

function __my_zplug() {
  local plugin=$1
  local ghq_path="~/ghq/github.com/$plugin"
  if [ -d "$ghq_path" ]; then
    zplug "$ghq_path", from:local
  else
    zplug "$plugin"
  fi
}

# ドットの展開
__my_zplug "momo-lab/zsh-replace-multiple-dots"

# zload
zplug 'mollifier/zload', as:plugin
# FIXME なぜかfpathに追加されない…
fpath=(~/.zplug/repos/mollifier/zload $fpath)

# 自作関数群読み込み
# (この位置でfpathすることでzplugにcompinitしてもらう)
fpath=(~/.zfunc $fpath)

# install any uninstalled plugins
zplug check || zplug install
# load plugins
zplug load

# 自作関数のロード
for func in ~/.zfunc/[^_]*(:t); do
  autoload -Uz $func
done


