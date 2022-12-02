#!/bin/bash

# Checks if apt lists exist and generates them if not.
apt_get_update() {
    if [ "$(find /var/lib/apt/lists/* | wc -l)" = "0" ]; then
        echo "Running apt-get update..."
        apt-get update -y
    fi
}

# Checks if packages are installed and installs them if not
check_packages() {
    if ! dpkg -s "$@" >/dev/null 2>&1; then
        apt_get_update
        apt-get -y install --no-install-recommends "$@"
    fi
}

set -e

# Ensure apt is in non-interactive to avoid prompts
export DEBIAN_FRONTEND=noninteractive

check_packages apt-transport-https curl ca-certificates tar

echo "Activating package 'direnv'".

RELEASES="https://github.com/direnv/direnv/releases"
LATEST="${RELEASES}/latest"

ARCH=${ARCHITECTURE:-"amd64"}
AUTO_ENABLE=${AUTOENABLE:-true}
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

if [ "${AUTO_ENABLE}" = "true" ]; then
    BASHRC="${_REMOTE_USER_HOME}/.bashrc"
    ZSHRC="${_REMOTE_USER_HOME}/.zshrc"

    echo "Adding mcfly to ${BASHRC} and ${ZSHRC}"
    if [ -z "$(grep _direnv_hook ${BASHRC})" ]; then
        direnv hook bash >>${BASHRC}
    fi

    if [ -z "$(grep _direnv_hook ${ZSHRC})"]; then
        direnv hook zsh >>${ZSHRC}
    fi
fi
