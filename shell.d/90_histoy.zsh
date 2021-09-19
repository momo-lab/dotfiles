# History
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000

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

# 重複を記録しない
setopt hist_ignore_dups

# Ctrl+Rでfzfで検索
function fzf-history-selection() {
  BUFFER=`history -n 1 | tac | awk '!a[$0]++' | fzf --select-1 --query="$BUFFER"`
  CURSOR=$#BUFFER
  zle reset-prompt
}
zle -N fzf-history-selection
bindkey '^R' fzf-history-selection
