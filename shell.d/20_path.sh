### PATH Settings

# XDG configuration
export XDG_CONFIG_HOME=$HOME/.config

# My Tools
export PATH="$HOME/bin:$PATH"
export PATH="$HOME/.myscript/bin:$PATH"

# Installed zsh plugins
eval "$(sheldon source)"

# Added by the Heroku Toolbelt
if [[ -d "${HOME}/.heroku/bin" ]]; then
  export PATH="$PATH:${HOME}/.heroku/bin"
fi

# GOPATH
export GOPATH="$HOME/go"
export PATH="$PATH:$GOPATH/bin"
# goenvでGOPATHの管理をしないようにする
export GOENV_DISABLE_GOPATH=1
