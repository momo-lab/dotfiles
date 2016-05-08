### Added by the Heroku Toolbelt
if [[ -d "${HOME}/.heroku/bin" ]]; then
  export PATH="${HOME}/.heroku/bin:$PATH"
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
  # FIXME: .zcompdumpを消さないと、「__import: function definition file not found」って言われてしまう。
  rm ~/.zcompdump
  tmux -2 attach || tmux -2 new-session
fi
