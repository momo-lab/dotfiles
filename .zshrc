# Color
export TERM=xterm-256color

# Clone zplug:v1 if not found
#source ~/.zplug/zplug || { curl -fLo ~/.zplug/zplug --create-dirs git.io/zplug && source ~/.zplug/zplug }
# Clone zplug:v2 if not found
source ~/.zplug/init.zsh || { git clone -b v2 https://github.com/b4b4r07/zplug ~/.zplug && source ~/.zplug/init.zsh }

# zplugsを初期化しないとプラグインを多重読み込みしちゃう
unset zplugs
typeset -g -A zplugs

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
# gitリポジトリ管理
zplug "motemen/ghq", as:command, from:gh-r
# githubコマンド
zplug "github/hub", as:command, from:gh-r

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
  PROMPT="%~ ${vcs_info_msg_0_}%# "
  RPROMPT=
}
function _update_rbenv_msg() {
  ver=$(rbenv local 2> /dev/null)
  if [[ "$ver" != "" ]]; then
    RPROMPT="[ruby $ver]"
  fi
}
add-zsh-hook precmd _update_vcs_info_msg
add-zsh-hook precmd _update_rbenv_msg


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


# Aliases
alias ls="ls --color=auto -F"
alias ll="ls -l"
alias lla="ls -la"


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


# fzf連携
function gl() {
  local repo=$(ghq list | fzf --query "$*")
  if [[ "$repo" != "" ]]; then
    cd $(ghq root)/$repo
  fi
}

