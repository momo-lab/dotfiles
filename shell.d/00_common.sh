# default umask
umask 022

# Color
export TERM=xterm-256color

# fzf settings
export FZF_DEFAULT_OPTS="
  --layout=reverse
  --height=30% --inline-info
  --cycle
  --bind=ctrl-f:page-down,ctrl-b:page-up
"

# default editor
if which nvim >/dev/null 2>&1; then
  export EDITOR="nvim"
  alias vi="nvim"
else
  export EDITOR="vim"
  alias vi="vim"
fi

# Ctrl+S/Ctrl+Qの無効化
if [[ -t 0 ]]; then
  stty stop undef
  stty start undef
fi

# vim:ft=zsh
