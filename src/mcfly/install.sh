#!/bin/bash
set -e

echo "Activating feature 'mcfly'"

export MCFLY_PATH=${INSTALLPATH:-"/usr/local/bin/mcfly"}

RELEASES="https://github.com/cantino/mcfly/releases"
LATEST="${RELEASES}/latest"
ARCH=${ARCHITECTURE:-"x86_64"}
ARCH_TUPLE="${ARCH}-unknown-linux"
AUTO_ENABLE=${AUTOENABLE:-true}
LIBC=${LIBC:-"musl"}
VERSION=${VERSION:-"latest"}
if [ "${VERSION}" = "latest" ]; then
    VERSION=$(curl -si "${LATEST}" | awk '/location: /{ n=split($2,t,"/"); print t[n] }' | tr -d "\r\n")
fi

RELEASE_FILE="mcfly-${VERSION}-${ARCH_TUPLE}-${LIBC}.tar.gz"
RELEASE_URL="${RELEASES}/download/${VERSION}/${RELEASE_FILE}"

curl -L "${RELEASE_URL}" | tar xz && mv mcfly ${MCFLY_PATH}
chmod +x ${MCFLY_PATH}

set -x
if [ "${AUTO_ENABLE}" = "true" ]; then
    BASHRC="${_REMOTE_USER_HOME}/.bashrc"
    ZSHRC="${_REMOTE_USER_HOME}/.zshrc"

    echo "Adding mcfly to ${BASHRC} and ${ZSHRC}"
    if [ -z "$(grep \"mcfly init bash\" ${BASHRC})" ]; then
        echo -e "eval \"\$(mcfly init bash)\"" >>${BASHRC}
    fi

    if [ -z "$(grep \"mcfly init zsh\" ${ZSHRC})"]; then
        echo -e "eval \"\$(mcfly init zsh)\"" >>${ZSHRC}
    fi
fi
