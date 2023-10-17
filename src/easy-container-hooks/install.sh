#!/usr/bin/env sh

set -exu

get_hook_dir() {
    case $1 in
        onCreate)
            echo ${ONCREATEHOOKPATH}
            ;;
        postAttach)
            echo ${POSTATTACHHOOKPATH}
            ;;
        postCreate)
            echo ${POSTCREATEHOOKPATH}
            ;;
        postStart)
            echo ${POSTSTARTHOOKPATH}
            ;;
        updateContent)
            echo ${UPDATECONTENTHOOKPATH}
            ;;
        *)
            echo "UNKNOWN HOOK: $1";
            exit 1
    esac
}

emit_hook() {
    local HOOK_DIR=$(realpath --relative-to=. -m $1);

    cat ./run-hook.sh.tmpl | sed "s@#####REPLACE######@${HOOK_DIR}@";
}

for hook in "onCreate" "postAttach" "postCreate" "postStart" "updateContent"; do
    emit_hook "${HOOKSDIR}/$(get_hook_dir ${hook})" > /usr/local/bin/ezdc_${hook}.sh;
    chmod +x /usr/local/bin/ezdc_${hook}.sh;
done