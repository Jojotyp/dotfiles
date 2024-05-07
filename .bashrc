#!/usr/bin/bash

# If not running interactively, exit script
[[ $- != *i* ]] && return

# Load .dotfiles:
for file in ~/.{bash_aliases,bash_prompt}; do
    [ -r "$file" ] && [ -f "$file" ] && source "$file";
done;
unset file;

# set locale
export LANG="en_US.utf8"
export LC_CTYPE="en_US.utf8"
export LC_NUMERIC="en_US.utf8"
export LC_TIME="de_DE.utf8"
export LC_COLLATE="en_US.utf8"
export LC_MONETARY="de_DE.utf8"
export LC_MESSAGES="en_US.utf8"
export LC_PAPER="de_DE.utf8"
export LC_NAME="en_US.utf8"
export LC_ADDRESS="en_US.utf8"
export LC_TELEPHONE="en_US.utf8"
export LC_MEASUREMENT="de_DE.utf8"
export LC_IDENTIFICATION="en_US.utf8"
export LC_ALL=

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
