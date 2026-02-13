# bash history
export HISTFILE="$XDG_STATE_HOME/bash/history"
if [ ! -d "$(dirname "$HISTFILE")" ]; then
  mkdir -p "$(dirname "$HISTFILE")"
fi
