#!/usr/bin/env bash

echo "Initialize mise."
if ! which mise 2>&1 > /dev/null; then
  curl https://mise.run | sh
fi

~/.local/bin/mise install -y
