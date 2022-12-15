#!/bin/bash

# This test file will be executed against an auto-generated devcontainer.json that
# includes the 'mcfly' feature with no options.
#
# Eg:
# {
#    "image": "<..some-base-image...>",
#    "features": {
#      "mcfly": {}
#    }
# }
#
# This test can be run with the following command (from the root of this repo)
#    devcontainer features test \
#               --features mcfly\
#               --base-image mcr.microsoft.com/devcontainers/base:ubuntu .

set -e

# Optional: Import test library bundled with the devcontainer CLI
source dev-container-features-test-lib

# Feature-specific tests
# The 'check' command comes from the dev-container-features-test-lib.
check "version" bash -c "mcfly -V | grep -i mcfly"
check "bash-integration" bash -c "cat ~/.bashrc | grep 'source <(mcfly init bash)'"
check "zsh-integration" bash -c "cat ~/.zshrc | grep 'source <(mcfly init zsh)'"

# Report result
# If any of the checks above exited with a non-zero exit code, the test will fail.
reportResults
