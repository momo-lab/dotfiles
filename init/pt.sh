#!/bin/bash

INSTALL_DIR=~/bin
PT_VERSION=v2.1.1
PT_PATH=pt_linux_amd64
PT_URL=https://github.com/monochromegane/the_platinum_searcher/releases/download/${PT_VERSION}/${PT_PATH}.tar.gz
WORKDIR=$(mktemp -d --tmpdir=.)

echo "Install platinum searcher." >&2

cd $WORKDIR
curl -LO $PT_URL
tar xzf ${PT_PATH}.tar.gz
mkdir -p $INSTALL_DIR
cp ${PT_PATH}/pt $INSTALL_DIR
cd -
rm -rf $WORKDIR

