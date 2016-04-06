#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Customize to your needs...

# Setting peco
function peco-history-selection {
    BUFFER=`history -n 1 | tac | awk '!a[$0]++' | peco`
    CURSOR=$#BUFFER
    zle reset-prompt
}
zle -N peco-history-selection
bindkey '^R' peco-history-selection

function ptv {
  filepath="$(echo $(pt "$@" | peco --query "$LBUFFER" | awk -F : '{print "-c " $2 " \047" $1 "\047"}'))"
  if [ "$filepath" != "" ]; then
    eval $(echo "vim $filepath")
  fi
}

