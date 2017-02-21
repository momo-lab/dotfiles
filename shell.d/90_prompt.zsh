# Prompt
autoload -Uz vcs_info
autoload -Uz add-zsh-hook
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr '%F{green}+%f'
zstyle ':vcs_info:git:*' unstagedstr '%F{red}!%f'
zstyle ':vcs_info:*' formats '[%s:%b%c%u]'
zstyle ':vcs_info:*' actionformats '[%s:%b%c%u|%F{cyan}%a%f]'
zstyle ':vcs_info:git+set-message:*' hooks git-hook-begin git-untracked

function _update_path_msg() {
  PROMPT="%30<...<%~%# "
}

function +vi-git-hook-begin() {
  test $(command git rev-parse --is-inside-work-tree 2> /dev/null) = 'true'
  return $?
}

function +vi-git-untracked() {
  if command git status --porcelain 2> /dev/null \
    | awk '{print $1}' \
    | grep -F '??' > /dev/null 2>&1 ; then
    hook_com[unstaged]+='%F{red}?%f'
  fi
}

function _update_vcs_info_msg() {
  LANG=en_US.UTF-8 vcs_info
  RPROMPT="${vcs_info_msg_0_}"
}

function _update_rbenv_msg() {
  ver=$(rbenv local 2> /dev/null)
  if [[ "$ver" != "" ]]; then
    RPROMPT="${RPROMPT}[ruby $ver]"
  fi
}

function _update_pyenv_msg() {
  ver=$(pyenv local 2> /dev/null)
  if [[ "$ver" != "" ]]; then
    RPROMPT="${RPROMPT}[python $ver]"
  fi
}

add-zsh-hook precmd _update_path_msg
add-zsh-hook precmd _update_vcs_info_msg
add-zsh-hook precmd _update_rbenv_msg
add-zsh-hook precmd _update_pyenv_msg

