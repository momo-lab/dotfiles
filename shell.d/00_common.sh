# Color
export TERM=xterm-256color

# XDG configuration
export XDG_CONFIG_HOME=$HOME/.config

### Added by the Heroku Toolbelt
if [[ -d "${HOME}/.heroku/bin" ]]; then
  export PATH="${HOME}/.heroku/bin:$PATH"
fi

### Added by anyenv
if [[ -d "${HOME}/.anyenv/bin" ]]; then
  export PATH="${HOME}/.anyenv/bin:$PATH"
  eval "$(anyenv init -)"
fi

# GOPATH
export GOPATH="$HOME/.go"
export PATH="$PATH:$GOROOT/bin:$GOPATH/bin"

### Added by $HOME/bin
export PATH="$HOME/bin:$PATH"
export PATH="$HOME/.myscript/bin:$PATH"

# default editor
if which nvim >/dev/null 2>&1; then
  export EDITOR="nvim"
  alias vi="nvim"
else
  export EDITOR="vim"
  alias vi="vim"
fi

# Aliases
alias ls="ls --color=auto -F"
alias ll="ls -l"
alias lla="ls -la"

alias gi="git localinfo"
alias gsall='gi `ghq list -p`'
alias gl="ghq-cd"

alias rb="bundruby"

function jqless() {
  cat ${1:--} | jq ${2:-.} -C | less -RXF
}

# vim:ft=zsh
