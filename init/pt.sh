#!/bin/bash

INSTALL_DIR=~/bin
VERSION=v2.1.1
FILENAME=pt_linux_amd64
URL=https://github.com/monochromegane/the_platinum_searcher/releases/download/${VERSION}/${FILENAME}.tar.gz
COMMAND_NAME=pt
WORKDIR=$(mktemp -d --tmpdir=.)

echo "Install platinum searcher." >&2

cd $WORKDIR
curl -LO $URL
tar vxzf ${FILENAME}.tar.gz
mkdir -p $INSTALL_DIR
cp -v ${FILENAME}/${COMMAND_NAME} $INSTALL_DIR
cd -
rm -rf $WORKDIR

