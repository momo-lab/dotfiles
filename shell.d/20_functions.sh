# ghqとfzf連携
ghq-cd() {
  local repo=$(ghq list --full-path |
    sed "s:$HOME/::" |
    fzf --query="$*" --select-1 --preview 'cd $HOME/{}; git localinfo')
  if [[ "$repo" != "" ]]; then
    cd $(readlink -f $HOME/$repo)
  fi
}

# jqした結果をlessで表示
function jqless() {
  cat ${1:--} | jq ${2:-.} -C | less -RXF
}
