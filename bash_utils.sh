#!/usr/bin/bash
############################
# This script provides utility functions for other scripts
############################

# usage: confirm "YOUR_OPTIONAL_TEXT" && COMMAND (do something in case && evaluates to true)
confirm() {
    # call with a prompt string or use a default
    read -r -p "${1:-Are you sure?} [y/N] " response
    case "$response" in
        [yY][eE][sS]|[yY]) 
            true
            ;;
        *)
            false
            ;;
    esac
}
