### PATH Settings

# XDG configuration
export XDG_CONFIG_HOME=$HOME/.config
export XDG_RUNTIME_DIR=$HOME/.run
if [ ! -d "$XDG_RUNTIME_DIR" ]; then
  mkdir -p "$XDG_RUNTIME_DIR"
  chmod 700 "$XDG_RUNTIME_DIR"
fi

# My Tools
export PATH="$HOME/.myscript/bin:$PATH"

# Installed zsh plugins
export PATH="$HOME/.local/bin:$PATH"
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

# pnpm
export PNPM_HOME="/home/momotaro/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
