# aliases
alias ls="ls --color=auto -F"
alias ll="ls -l"
alias lla="ls -la"

alias rb="bundruby"

# abbrev-alias
type abbrev-alias >/dev/null 2>&1 || return

# global abbrev-alias
abbrev-alias -g G='| grep'
abbrev-alias -g E='2>&1 > /dev/null'
abbrev-alias -g N='> /dev/null'
# for git
abbrev-alias -ge B='$(git symbolic-ref --short HEAD 2> /dev/null)'
abbrev-alias -ge OB='origin $(git symbolic-ref --short HEAD 2> /dev/null)'

abbrev-alias g='git'
abbrev-alias ga='git add'
abbrev-alias gap='git add -p'
abbrev-alias gaa='git add -A'
abbrev-alias gb='git br'
abbrev-alias gc='git commit'
abbrev-alias gcm='git commit -m'
abbrev-alias gd='git diff'
abbrev-alias gds='git diffs'
abbrev-alias gm='git merge'
abbrev-alias gmn='git merge --no-edit'
abbrev-alias gr='git rebase'
abbrev-alias gri='git rebase -i'
abbrev-alias gf='git flow'
abbrev-alias gff='git flow feature'
abbrev-alias gi="git localinfo"

abbrev-alias gl="ghq-cd"
abbrev-alias gg='ghq-git'
abbrev-alias ggi='ghq-git localinfo'

abbrev-alias sw='split-window'

abbrev-alias edit='tmux split-window -hb $EDITOR'
