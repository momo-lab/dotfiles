### tmux起動
if [[ -x "$(which tmux)" && -z $TMUX ]]; then
  # FIXME: .zcompdumpを消さないと、「__import: function definition file not found」って言われてしまう。
  rm ~/.zcompdump
  tmux -2 attach || tmux -2 new-session
fi
