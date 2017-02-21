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
# gitのルートに移動
zplug "mollifier/cd-gitroot"
# git nowサブコマンド
zplug "iwata/git-now", as:command, use:"{git-now,gitnow}*"

# 選択的インタフェースなやつ
zplug "junegunn/fzf-bin", as:command, from:gh-r, as:command, rename-to:fzf
zplug "momo-lab/fzy", at:develop, as:command, hook-build:'make'
# grepのすごいやつ
zplug "monochromegane/the_platinum_searcher", as:command, from:gh-r, rename-to:pt
# TODO このままだとripgrepがインストールされなかったので手動でいれた
zplug "BurntSushi/ripgrep", as:command, from:gh-r, rename-to:rg
# JSONパース用コマンド
zplug "stedolan/jq", as:command, from:gh-r
# gitリポジトリ管理
zplug "motemen/ghq", as:command, from:gh-r
#zplug "sona-tar/ghs", as:command, from:gh-r
# gitコマンド拡張
zplug "b4b4r07/git-br", as:command, use:'git-br'
# ssh-keyをgithub/bitbucketに登録
zplug "b4b4r07/ssh-keyreg"
# githubコマンド
zplug "github/hub", as:command, from:gh-r
# ゴミ箱
zplug "b4b4r07/zsh-gomi"
# Google翻訳
zplug "soimort/translate-shell", \
  at:stable, as:command, use:"build/*", \
  hook-build:"make build &> /dev/null"

# 短縮展開
zplug "momo-lab/zsh-abbrev-alias"
# for develop
#zplug "~/.ghq/github.com/momo-lab/zsh-abbrev-alias", from:local

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


