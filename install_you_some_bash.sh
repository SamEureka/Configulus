#!/bin/ash

check_and_install_you_some_bash(){
    local TIMEOUT_COUNT=0
    while [ ! -f "/bin/bash" ] && [ "$TIMEOUT_COUNT" -lt 3 ]; do
        echo "get you some bash!"
        apk add bash
        let "TIMEOUT_COUNT++"
    done
    
    if [ -f "/bin/bash" ]; then
        echo "We have positive bashage!"
        exec bash
    else
        echo "We tried a few times.... no bash for you."
        exit 1337
    fi
}