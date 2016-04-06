### prezto
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/runcoms/zlogin" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/runcoms/zlogin"
fi

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

### Added by $HOME/bin
export PATH="$HOME/bin:$PATH"
