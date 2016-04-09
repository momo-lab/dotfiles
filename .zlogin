### prezto
#if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/runcoms/zlogin" ]]; then
#  source "${ZDOTDIR:-$HOME}/.zprezto/runcoms/zlogin"
#fi

### Added by the Heroku Toolbelt
if [[ -d "/usr/local/heroku/bin" ]]; then
  export PATH="/usr/local/heroku/bin:$PATH"
fi

### Added by rbenv
if [[ -d "${HOME}/.rbenv/bin" ]]; then
  export PATH="${HOME}/.rbenv/bin:$PATH"
  eval "$(rbenv init - --no-rehash zsh)"
fi

### Added by $HOME/bin
export PATH="$HOME/bin:$PATH"

### tmux起動
if [[ -x "$(which tmux)" && -z $TMUX ]]; then
  tmux -2 attach || tmux -2 new-session
fi
