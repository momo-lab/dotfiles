#!/bin/bash

echo "Initialize nvim plugins."
if which nvim 2>&1 > /dev/null; then
  nvim --headless +qall
fi
