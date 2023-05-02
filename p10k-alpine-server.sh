#!/bin/bash

## P10k Install Script (for Alpine servers)
## Sam Dennon // 2022
## Updated: 27APR2023
## German translations by ChatGPT # LOL ##

# Globals
TIMEOUT_COUNT=0
PACKAGES="git nano zsh curl sudo neofetch shadow util-linux"
FUNCS_TO_CALL=""

## root or sudo check
root_sudo_check() {
    if [ "$(id -u)" -eq 0 ]; then
        echo "You have permission to run this script as root."
    else
        if groups $USER | grep -q sudo; then
            echo "You have permission to run this script with sudo."
        else
            echo "You do not have permission to run this script. Get some sudo and try again!"
            exit 1337
        fi
    fi
}

