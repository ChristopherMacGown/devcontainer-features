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

if [ "${AUTO_ENABLE}" = "true" ]; then
    BASHRC="${_REMOTE_USER_HOME}/.bashrc"
    ZSHRC="${_REMOTE_USER_HOME}/.zshrc"

    echo "Adding mcfly to ${BASHRC} and ${ZSHRC}"
    if [ -z "$(grep \"mcfly init bash\" ${BASHRC})" ]; then
        echo -e "export MCFLY_HISTFILE=\"\${HISTFILE:-\$HOME/.bash_history}\"" >>${BASHRC}
        echo -e "source <(mcfly init bash)" >>${BASHRC}
    fi

    if [ -z "$(grep \"mcfly init zsh\" ${ZSHRC})"]; then
        echo -e "export MCFLY_HISTFILE=\"\${HISTFILE:-\$HOME/.zsh_history}\"" >>${ZSHRC}
        echo -e "source <(mcfly init zsh)" >>${ZSHRC}
    fi
fi
