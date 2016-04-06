#!/bin/bash

INSTALL_DIR=~/bin
VERSION=v0.3.5
FILENAME=peco_linux_amd64
URL=https://github.com/peco/peco/releases/download/${VERSION}/${FILENAME}.tar.gz
COMMAND_NAME=peco
WORKDIR=$(mktemp -d --tmpdir=.)

echo "Install platinum searcher." >&2

cd $WORKDIR
curl -LO $URL
tar vxzf ${FILENAME}.tar.gz
mkdir -p $INSTALL_DIR
cp -v ${FILENAME}/${COMMAND_NAME} $INSTALL_DIR
cd -
rm -rf $WORKDIR

