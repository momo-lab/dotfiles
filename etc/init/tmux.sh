#!/bin/bash

tpm_url="https://github.com/tmux-plugins/tpm"
tpm_root=${HOME}/.tmux/plugins/tpm

echo "Initialize tmux plugins."
if [[ ! -d "$tpm_root" ]]; then
  git clone $tpm_url $tpm_root
  $tpm_root/bin/install_plugins
fi
