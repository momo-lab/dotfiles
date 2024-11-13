#!/usr/bin/env bash

if ! which mise 2>&1 > /dev/null; then
  curl https://mise.run | sh
fi

~/.local/bin/mise install -y
