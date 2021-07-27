### PATH Settings

# XDG configuration
export XDG_CONFIG_HOME=$HOME/.config

# My Tools
export PATH="$HOME/bin:$PATH"
export PATH="$HOME/.myscript/bin:$PATH"

# Installed Tools
export GHR_GET_ROOT=$HOME/.ghr-get
export PATH=$GHR_GET_ROOT/bin:$PATH
type ghr-get > /dev/null 2>&1 && eval "$(ghr-get init -)"

# Added by the Heroku Toolbelt
if [[ -d "${HOME}/.heroku/bin" ]]; then
  export PATH="$PATH:${HOME}/.heroku/bin"
fi

# Added by anyenv
if [[ -d "${HOME}/.anyenv/bin" ]]; then
  export ANYENV_DEFINITION_ROOT=${HOME}/.anyenv/plugins/anyenv-install
  export PATH="${HOME}/.anyenv/bin:$PATH"
  if [[ -f "${HOME}/.anyenv-rc.sh" ]]; then
    source ${HOME}/.anyenv-rc.sh
  fi
fi

# GOPATH
export GOPATH="$HOME/go"
export PATH="$PATH:$GOPATH/bin"
# goenvでGOPATHの管理をしないようにする
export GOENV_DISABLE_GOPATH=1
