#!/bin/bash

# This test file will be executed against an auto-generated devcontainer.json that
# includes the 'direnv' feature with no options.
#
# Eg:
# {
#    "image": "<..some-base-image...>",
#    "features": {
#      "direnv": {}
#    }
# }
#
# This test can be run with the following command (from the root of this repo)
#    devcontainer features test \
#               --features direnv\
#               --base-image mcr.microsoft.com/devcontainers/base:ubuntu .

set -e

# Optional: Import test library bundled with the devcontainer CLI
source dev-container-features-test-lib

# Feature-specific tests
# The 'check' command comes from the dev-container-features-test-lib.
check "version" bash -c "direnv help | grep direnv | head -1"
check "bash-integration" bash -c "cat ~/.bashrc | grep _direnv_hook\(\)"
check "zsh-integration" bash -c "cat ~/.zshrc | grep _direnv_hook\(\)"

# Report result
# If any of the checks above exited with a non-zero exit code, the test will fail.
reportResults
