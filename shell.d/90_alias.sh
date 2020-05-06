# abbrev-alias
#type abbrev-alias >/dev/null 2>&1 || return

# global alias
#if [[ "$SHELL" =~ /zsh$ ]]; then
#  alias -g G='| grep'
#  alias -g E='2>&1 > /dev/null'
#  alias -g N='> /dev/null'
#  # for git
#  alias -g B='$(git symbolic-ref --short HEAD 2> /dev/null)'
#  alias -g OB='origin $(git symbolic-ref --short HEAD 2> /dev/null)'
#fi

alias g='git'
alias ga='git add'
alias gap='git add -p'
alias gaa='git add -A'
alias gb='git br'
alias gc='git commit'
alias gcm='git commit -m'
alias gd='git diff'
alias gds='git diffs'
alias gm='git merge'
alias gmn='git merge --no-edit'
alias gr='git rebase'
alias gri='git rebase -i'
alias gf='git flow'
alias gff='git flow feature'
