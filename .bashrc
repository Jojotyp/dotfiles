#!/usr/bin/bash

# If not running interactively, exit script
[[ $- != *i* ]] && return

# Load .dotfiles:
for file in ~/.{bash_aliases,bash_prompt}; do
    [ -r "$file" ] && [ -f "$file" ] && source "$file";
done;
unset file;

# set locale
export LANG=en_US.utf8

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=10000

# ignore hgrep alias for .bash_history
export HISTIGNORE="$HISTIGNORE:hgrep*"

# PATH variables
# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Individual programs or binaries
## Imagick
if [ -d "/opt/ImageMagick" ]; then
    export MAGICK_HOME="/opt/ImageMagick"
    export PATH="$MAGICK_HOME/bin:$PATH"
#    PATH="$PATH:/opt/ImageMagick"
    LD_LIBRARY_PATH="${LD_LIBRARY_PATH:+$LD_LIBRARY_PATH:}$MAGICK_HOME/lib"
    export LD_LIBRARY_PATH
fi

## PhpStorm
if [ -d "/opt/PhpStorm" ]; then
    PATH="$PATH:/opt/PhpStorm/bin"
fi
