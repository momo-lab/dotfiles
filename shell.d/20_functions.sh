# ghqとfzf連携
ghq-cd() {
  local repo=$(ghq list --full-path |
    sed "s:$HOME/::" |
    fzf --query="$*" --select-1 --preview 'cd $HOME/{}; git localinfo')
  if [[ "$repo" != "" ]]; then
    cd $(readlink -f $HOME/$repo)
  fi
}
