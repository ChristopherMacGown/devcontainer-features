#!/bin/bash

set -e

RELEASES="https://github.com/direnv/direnv/releases"
LATEST="${RELEASES}/latest"

ARCH=${ARCHITECTURE:-"amd64"}
VERSION=${VERSION:-"latest"}
INSTALL_PATH=${INSTALLPATH:-"/usr/local/bin/direnv"}
if [ "${VERSION}" = "latest" ]; then
    VERSION=$(curl -si "${LATEST}" | awk '/location: /{ n=split($2,t,"/"); print t[n] }' | tr -d "\r\n")
fi

set -x

RELEASE_FILE="direnv.linux-${ARCH}"
RELEASE_URL="${RELEASES}/download/${VERSION}/${RELEASE_FILE}"

curl -o ${INSTALL_PATH} -fL "${RELEASE_URL}"
chmod +x ${INSTALL_PATH}
