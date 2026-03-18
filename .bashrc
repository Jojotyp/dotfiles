#!/usr/bin/bash

# If not running interactively, exit script
[[ $- != *i* ]] && return

# enable autocomplete for commands after sudo
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

complete -cf sudo

# Load dotfiles:
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


# Load locale, PATH variables:
for file in ~/dotfiles/load/{locale_variables,path_variables}; do
    . $file.sh
done;
unset file;


# # Set up fzf key bindings and fuzzy completion; needs at least version 0.48.0
# if command -v fzf >/dev/null 2>&1; then
#   eval "$(fzf --bash)"
# fi