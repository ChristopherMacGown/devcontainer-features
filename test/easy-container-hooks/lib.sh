function ensure_hook_dir() {
    mkdir -p $1;
}

function write_test_hook() {
    OUTPUT=${2:-$(basename $1)};
    cat <<HOOK > "$1/test_${OUTPUT}.sh"
#!/usr/bin/env bash

set -e

echo ${OUTPUT}
HOOK
}

function get_hook_runner() {
    case $1 in
        on-create)      echo "/usr/local/bin/ezdc_onCreate.sh";;
        post-attach)    echo "/usr/local/bin/ezdc_postAttach.sh";;
        post-create)    echo "/usr/local/bin/ezdc_postCreate.sh";;
        post-start)     echo "/usr/local/bin/ezdc_postStart.sh";;
        update-content) echo "/usr/local/bin/ezdc_updateContent.sh";;
    esac
}

function test_hook() {
    EXPECTATION=$1
    HOOK=$2

    cat $(get_hook_runner $HOOK)

    check "runner-installed $HOOK" bash -c "cat $(get_hook_runner $HOOK) | grep HOOKS=${EXPECTATION}"
    check "runner-runs-hooks $HOOK" bash -c "$(get_hook_runner $HOOK) | grep $HOOK"
}