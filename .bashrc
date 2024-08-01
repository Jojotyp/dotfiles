#!/usr/bin/bash

# If not running interactively, exit script
[[ $- != *i* ]] && return

# enable autocomplete for commands after sudo
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

# Load .dotfiles:
for file in ~/.{bash_aliases,bash_prompt,path_variables}; do
    [ -r "$file" ] && [ -f "$file" ] && source "$file";
done;
unset file;

# TODO: replace LOCALE stuff below with the file stuff

# set locale
export LANG=en_US.utf8
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
export LC_ALL=en_US.utf8

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=10000

# ignore hgrep alias for .bash_history
export HISTIGNORE="$HISTIGNORE:hgrep*"


# TODO: replace PATH stuff below with the directly following

# # Load path variables
# if [ -f ~/path_variables.sh ]; then
#     echo "LOADING PATH vars"
#     . ~/path_variables.sh
# else
#     echo "NOPE"
# fi


# Set Flatpak application paths to show them in desktop environment
if [ -z "${XDG_DATA_DIRS-}" ]; then
    XDG_DATA_DIRS="/usr/local/share:/usr/share"
fi
XDG_DATA_DIRS="/var/lib/flatpak/exports/share:${XDG_DATA_DIRS}"
XDG_DATA_DIRS="${HOME}/.local/share/flatpak/exports/share:${XDG_DATA_DIRS}"
export XDG_DATA_DIRS


# PATH variables #
# include system binaries for user
if [ -d "/sbin" ]; then
    export PATH="/sbin:$PATH"
fi

# include system binaries for user
if [ -d "/usr/sbin" ]; then
    export PATH="/usr/sbin:$PATH"
fi

# user's private bin if it exists
if [ -d "$HOME/bin" ]; then
    export PATH="$HOME/bin:$PATH"
fi

# user's private bin if it exists
if [ -d "$HOME/.local/bin" ]; then
    export PATH="$HOME/.local/bin:$PATH"
fi

# Individual programs, binaries or configs
## Android Studio
if [ -d "/opt/android-studio/bin" ]; then
    export PATH="/opt/android-studio/bin:$PATH"
fi

## Android platform-tools
if [ -d "$HOME/Android/Sdk" ]; then
    export ANDROID_HOME="$HOME/Android/Sdk"
    export PATH="$PATH:$ANDROID_HOME/cmdline-tools/latest/bin"
    export PATH="$PATH:$ANDROID_HOME/emulator"
    export PATH="$PATH:$ANDROID_HOME/platform-tools"

    export ANDROID_SDK_ROOT="$HOME/Android/Sdk"
fi

# ## Android platform-tools
# if [ -d "/usr/lib/android-sdk/cmdline-tools" ] && [ -d "/usr/lib/android-sdk/platform-tools" ]; then
#     export ANDROID_HOME="/usr/lib/android-sdk"
#     export PATH="$PATH:$ANDROID_HOME/cmdline-tools/bin"
#     export PATH="$PATH:$ANDROID_HOME/platform-tools"
# fi

# IntelliJ IDEA
if [ -d "$HOME/.local/share/applications" ]; then
    export PATH="$HOME/.local/share/applications:$PATH"
fi

## Imagick
if [ -d "/opt/ImageMagick" ]; then
    export MAGICK_HOME="/opt/ImageMagick"
    export PATH="$MAGICK_HOME/bin:$PATH"
    LD_LIBRARY_PATH="${LD_LIBRARY_PATH:+$LD_LIBRARY_PATH:}$MAGICK_HOME/lib"
    export LD_LIBRARY_PATH
fi

## jdk (Java)
if [ -d "/usr/lib/jvm" ]; then
    export JAVA_HOME=$(dirname $(dirname $(readlink -f /usr/bin/java))) # dynamically determine path to jdk
    export PATH="${JAVA_HOME}/bin:$PATH" # something like: /usr/lib/jvm/jdk-[VERSION]-oracle-x64/bin
fi

## nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

## OpenSSL
export OPENSSL_ROOT_DIR="/usr/"

## PhpStorm
if [ -d "/opt/PhpStorm" ]; then
    export PATH="/opt/PhpStorm/bin:$PATH"
fi

## Toolbox
if [ -d "$HOME/.local/share/JetBrains/Toolbox/scripts" ]; then
    export ATH="$HOME/.local/share/JetBrains/Toolbox/scripts:$PATH"
fi

## Cargo (Rust)
if [ -d "$HOME/.cargo/env" ]; then 
    . "$HOME/.cargo/env"
fi
