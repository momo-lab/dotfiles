#!/bin/bash

INSTALL_ROOT=$HOME
VERSION=2.1.1
FILENAME=tig-${VERSION}
URL=http://jonas.nitro.dk/tig/releases/${FILENAME}.tar.gz
WORKDIR=$(mktemp -d --tmpdir=.)

echo "Install Tig." >&2

cd $WORKDIR
curl -LO $URL
tar vxzf ${FILENAME}.tar.gz
cd ${FILENAME}
./configure
make prefix=${INSTALL_ROOT}
make install prefix=${INSTALL_ROOT}
cd ../..
rm -rf $WORKDIR

