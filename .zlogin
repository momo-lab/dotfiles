### Added by the Heroku Toolbelt
if [[ -d "/usr/local/heroku/bin" ]]; then
  export PATH="/usr/local/heroku/bin:$PATH"
fi

### Added by rbenv
if [[ -d "${HOME}/.rbenv/bin" ]]; then
  export PATH="${HOME}/.rbenv/bin:$PATH"
  eval "$(rbenv init - --no-rehash zsh)"
fi

# Load pyenv automatically by adding
# the following to ~/.zshrc:
if [[ -d "${HOME}/.pyenv/bin" ]]; then
  export PATH="${HOME}/.pyenv/bin:$PATH"
  eval "$(pyenv init -)"
  eval "$(pyenv virtualenv-init -)"
fi

### Added by $HOME/bin
export PATH="$HOME/bin:$PATH"
export PATH="$HOME/.myscript/bin:$PATH"

### tmux起動
if [[ -x "$(which tmux)" && -z $TMUX ]]; then
  tmux -2 attach || tmux -2 new-session
fi
