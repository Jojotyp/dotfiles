#!/usr/bin/bash
############################
# This script creates symlinks from the home directory to any desired .dotfiles in $HOME/.dotfiles
############################

source "$(dirname $(readlink -f "$0"))/config.sh"
