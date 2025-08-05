# ghqとfzf連携
ghq-cd() {
  local repo=$(ghq list --full-path |
    sed "s:$HOME/::" |
    fzf --query="$*" --select-1 --preview 'cd $HOME/{}; git localinfo')
  if [[ "$repo" != "" ]]; then
    cd $(readlink -f $HOME/$repo)
  fi
}

# C-nで新しいwindowでプロジェクトを開く
ghq-open() {
  local repo=$(ghq list --full-path |
    sed "s:$HOME/::" |
    fzf --tmux --query="$*" --select-1 --preview 'cd $HOME/{}; git localinfo')
  if [[ "$repo" != "" ]]; then
    tmux new-window -c $(readlink -f $HOME/$repo)
    local name=$(basename $repo)
    tmux rename-window "$name"
    split-window $(readlink -f $HOME/$repo)
  fi
}

# jqした結果をlessで表示
function jqless() {
  cat ${1:--} | jq ${2:-.} -C | less -RXF
}
