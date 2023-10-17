#!/bin/bash
#
# This test file will be executed against an auto-generated devcontainer.json that
# includes the "easy-container-hooks" feature with no options.
#
#
# This test can be run with the following command:
#
#    devcontainer features test \ 
#                   --features easy-container-hooks \
#                   --base-image mcr.microsoft.com/devcontainers/base:ubuntu \
#                   .

set -e

source dev-container-features-test-lib
source ./lib.sh

for HOOK in "on-create" "post-attach" "post-create" "post-start" "update-content"; do
    HOOK_DIR=".devcontainer/hooks/$HOOK";
    if [[ ${HOOK} = "on-create" ]]; then
        HOOK_DIR=".devcontainer/hooks/create-on";
    fi
    ensure_hook_dir ${HOOK_DIR}
    write_test_hook ${HOOK_DIR} ${HOOK}
    test_hook ${HOOK_DIR} ${HOOK}
done

# Report results
# If any of the checks above exited with a non-zero exit code, the test will fail.
reportResults