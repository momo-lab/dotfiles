# ghqとfzf連携
ghq-cd() {
  local repo=$(ghq list --full-path | fzf --query="$*" --select-1)
  if [[ "$repo" != "" ]]; then
    cd $(readlink -f $repo)
  fi
}
