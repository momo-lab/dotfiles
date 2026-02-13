if [ -n "$WSL_DISTRO_NAME" ]; then
  # VcXsrv Windows X Server settings
  #export DISPLAY=$(hostname).mshome.net:0.0
  export DISPLAY=:0

  # WSL用 XDG_RUNTIME_DIR
  export XDG_RUNTIME_DIR="$HOME/.run"
  if [ ! -d "$XDG_RUNTIME_DIR" ]; then
    mkdir -p "$XDG_RUNTIME_DIR"
    chmod 700 "$XDG_RUNTIME_DIR"
  fi
fi
