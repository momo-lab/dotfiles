# Prompt
autoload -Uz vcs_info
autoload -Uz add-zsh-hook
zstyle ':vcs_info:*' max-exports 4
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr '+'
zstyle ':vcs_info:git:*' unstagedstr '!'
zstyle ':vcs_info:*' formats '%s:%b' '%c' '%u'
zstyle ':vcs_info:*' actionformats '%s:%b' '%c' '%u' '%a'
zstyle ':vcs_info:git+set-message:*' hooks git-hook-begin git-untracked

function +vi-git-hook-begin() {
  test $(command git rev-parse --is-inside-work-tree 2> /dev/null) = 'true'
  return $?
}

function +vi-git-untracked() {
  if [[ "$1" != "1" ]]; then
    return 0
  fi
  if command git status --porcelain 2> /dev/null \
    | awk '{print $1}' \
    | grep -F '??' > /dev/null 2>&1 ; then
    hook_com[unstaged]+='?'
  fi
}

function _update_vcs_info_msg() {
  LANG=en_US.UTF-8 vcs_info
  local prompt
  if [[ -z ${vcs_info_msg_0_} ]]; then
    prompt=""
  else
    prompt="[${vcs_info_msg_0_}%F{green}${vcs_info_msg_1_}%F{red}${vcs_info_msg_2_}%f"
    if [[ -n ${vcs_info_msg_3_} ]]; then
      prompt+="|%F{cyan}${vcs_info_msg_3_}%f"
    fi
    prompt+="]"
  fi
  [ -n $prompt ] && echo -n "$prompt"
}

function _update_anyenv_msg() {
  local result=""
  local env ver
  for env in $(anyenv envs); do
    ver=$($env local 2> /dev/null)
    [ $? -eq 0 ] && [ -n $ver ] && result+="[$env $ver]"
  done
  [ -n $result ] && echo -n "$result"
}

function _update_prompt() {
  if [ -n $TMUX ]; then
    tmux refresh-client -S
    PROMPT="%(?..%{$bg[red]%}<%?>%{$reset_color%})# "
    RPROMPT=""
  else
    PROMPT="%30<...<%~% %(?..%{$bg[red]%}<%?>%{$reset_color%})# "
    RPROMPT="$(_update_vcs_info_msg)$(_update_anyenv_msg)"
  fi
}

add-zsh-hook precmd _update_prompt
