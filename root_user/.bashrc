#!/usr/bin/bash

# If not running interactively, exit script
[[ $- != *i* ]] && return

# Load .dotfiles:
for file in ~/.{bash_aliases,bash_prompt}; do
    [ -r "$file" ] && [ -f "$file" ] && source "$file";
done;
unset file;

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=10000

# ignore hgrep alias for .bash_history
export HISTIGNORE="$HISTIGNORE:hgrep*"

