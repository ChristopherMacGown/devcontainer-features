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

export MINIO_PATH=${INSTALLPATH:-"/usr/local/bin/mc"}
export MINIO_VENDOR=${VENDOR:-"linux"}

if -z "${ARCHITECTURE+x}"
then
    case `uname -m` in
        aarch64)
            MINIO_ARCH=amd64;;
        *)
            MINIO_ARCH=`uname -m`;;
    esac
else
    MINIO_ARCH=${ARCHITECTURE}
fi
export MINIO_ARCH

DOWNLOAD_PATH="https://dl.min.io/client/mc/release/${MINIO_VENDOR}-${MINIO_ARCH}/"

# Ensure apt is in non-interactive to avoid prompts
export DEBIAN_FRONTEND=noninteractive

echo "Activating feature 'minio-client'"
check_packages apt-transport-https curl ca-certificates

RELEASE_HASH=$(curl -sL "${DOWNLOAD_PATH}/mc.sha256sum")
RELEASE_FILE=${RELEASE_HASH#* }

curl -sLO "${DOWNLOAD_PATH}/${RELEASE_FILE}"
if [[ $(sha256sum --check <<< "${RELEASE_HASH}") = "${RELEASE_FILE}: OK" ]]; then
    chmod a+x ${RELEASE_FILE}
    mv ${RELEASE_FILE} ${MINIO_PATH}
    exit 0
fi

echo "Invalid checksum for ${RELEASE_FILE}"
rm ${RELEASE_FILE}
exit -1
