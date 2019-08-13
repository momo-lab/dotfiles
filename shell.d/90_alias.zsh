# abbrev-alias
# for pipe
abbrev-alias -g G="| grep"
abbrev-alias -g E="2>&1 > /dev/null"
abbrev-alias -g N="> /dev/null"
# for git
abbrev-alias -g -e B='$(git symbolic-ref --short HEAD 2> /dev/null)'
abbrev-alias g="git"
abbrev-alias ga="git add"
abbrev-alias gap="git add -p"
abbrev-alias gaa="git add -A"
abbrev-alias gb="git br"
abbrev-alias gc="git commit"
abbrev-alias gcm="git commit -m"
abbrev-alias gd="git diff"
abbrev-alias gds="git diffs"
abbrev-alias gm="git merge"
abbrev-alias gmn="git merge --no-edit"
abbrev-alias gr="git rebase"
abbrev-alias gri="git rebase -i"
abbrev-alias gf="git flow"
abbrev-alias gff="git flow feature"
