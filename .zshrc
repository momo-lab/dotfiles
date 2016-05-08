# Color
export TERM=xterm-256color

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

# 選択的インタフェースなやつ
zplug "junegunn/fzf-bin", as:command, from:gh-r, as:command, rename-to:fzf
# grepのすごいやつ
zplug "monochromegane/the_platinum_searcher", as:command, from:gh-r, rename-to:pt
# JSONパース用コマンド
zplug "stedolan/jq", as:command, from:gh-r
# gitリポジトリ管理
zplug "motemen/ghq", as:command, from:gh-r
zplug "sona-tar/ghs", as:command, from:gh-r
# ssh-keyをgithub/bitbucketに登録
zplug "b4b4r07/ssh-keyreg", as:command, use:bin
# githubコマンド
zplug "github/hub", as:command, from:gh-r
# ゴミ箱
zplug "b4b4r07/zsh-gomi"

# zload
zplug 'mollifier/zload', as:plugin
# FIXME なぜかfpathに追加されない…
fpath=(~/.zplug/repos/mollifier/zload $fpath)

# install any uninstalled plugins
zplug check || zplug install
# load plugins
zplug load


# History
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000


# Completions
autoload -Uz compinit; compinit -i

# Group matches and describe.
zstyle ':completion:*:*:*:*:*' menu select
zstyle ':completion:*:matches' group 'yes'
zstyle ':completion:*:options' description 'yes'
zstyle ':completion:*:options' auto-description '%d'
zstyle ':completion:*:corrections' format ' %F{green}-- %d (errors: %e) --%f'
zstyle ':completion:*:descriptions' format ' %F{yellow}-- %d --%f'
zstyle ':completion:*:messages' format ' %F{purple} -- %d --%f'
zstyle ':completion:*:warnings' format ' %F{red}-- no matches found --%f'
zstyle ':completion:*:default' list-prompt '%S%M matches%s'
zstyle ':completion:*' format ' %F{yellow}-- %d --%f'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' verbose yes


# Prompt
#autoload -U colors; colors
#PROMPT="%{${fg[cyan]}%}%d%{${reset_color}%}%# "
autoload -Uz vcs_info
autoload -Uz add-zsh-hook
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr '%F{green}+%f'
zstyle ':vcs_info:git:*' unstagedstr '%F{yellow}!%f'
zstyle ':vcs_info:*' formats '[%s:%b%c%u]'
zstyle ':vcs_info:*' actionformats '[%s:%b%c%u|%F{cyan}%a%f]'
function _update_vcs_info_msg() {
  LANG=en_US.UTF-8 vcs_info
  PROMPT="%30<...<%~%# "
  RPROMPT="${vcs_info_msg_0_}"
}
function _update_rbenv_msg() {
  ver=$(rbenv local 2> /dev/null)
  if [[ "$ver" != "" ]]; then
    RPROMPT="${RPROMPT}[ruby $ver]"
  fi
}
function _update_pyenv_msg() {
  ver=$(pyenv local 2> /dev/null)
  if [[ "$ver" != "" ]]; then
    RPROMPT="${RPROMPT}[python $ver]"
  fi
}
add-zsh-hook precmd _update_vcs_info_msg
add-zsh-hook precmd _update_rbenv_msg
add-zsh-hook precmd _update_pyenv_msg


# Setting zsh-history-substring-search
zmodload zsh/terminfo
bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey -M emacs '^K' history-substring-search-up
bindkey -M emacs '^J' history-substring-search-down
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down


# .zshrcを編集しやすくするテスト
function __load_zshrc() {
  echo
  source ~/.zshrc
  zle reset-prompt
}
zle -N __load_zshrc
bindkey "^[[15~" __load_zshrc # F5キー
# FIXME:viコマンドがうまく動いてくれない。。。
#function __edit_zshrc() {
#  vi ~/.zshrc
#  zle reset-prompt
#}
#zle -N __edit_zshrc
#bindkey "^[[17~" __edit_zshrc # F6キー

# 自作関数群読み込み
fpath=(~/.zfunc $fpath); compinit
for func in ~/.zfunc/[^_]*(:t); do
  autoload -Uz $func
done

# Aliases
alias ls="ls --color=auto -F"
alias ll="ls -l"
alias lla="ls -la"

alias gs="git status -sb; git stash list; git log --branches --not --remotes --oneline --graph --decorate"
alias gl="ghq-cd"

alias rb="bundruby"

