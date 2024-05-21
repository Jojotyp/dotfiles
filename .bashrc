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


# Set Flatpak application paths to show them in desktop environment
if [ -z "${XDG_DATA_DIRS-}" ]; then
    XDG_DATA_DIRS="/usr/local/share:/usr/share"
fi
XDG_DATA_DIRS="/var/lib/flatpak/exports/share:${XDG_DATA_DIRS}"
XDG_DATA_DIRS="${HOME}/.local/share/flatpak/exports/share:${XDG_DATA_DIRS}"
export XDG_DATA_DIRS


# PATH variables #
# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ]; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ]; then
    PATH="$HOME/.local/bin:$PATH"
fi

# Individual programs, binaries or configs
## Android Studio
if [ -d "/opt/android-studio/bin" ]; then
    PATH="/opt/android-studio/bin:$PATH"
fi

## Android platform-tools
if [ -d "$HOME/Android/Sdk" ]; then
    export ANDROID_HOME="$HOME/Android/Sdk"
    PATH="$PATH:$ANDROID_HOME/cmdline-tools/latest/bin"
    PATH="$PATH:$ANDROID_HOME/emulator"
    PATH="$PATH:$ANDROID_HOME/platform-tools"
    PATH="$PATH:$ANDROID_HOME/tools"
    PATH="$PATH:$ANDROID_HOME/tools/bin"

    export ANDROID_SDK_ROOT="$HOME/Android/Sdk"
    # PATH="$PATH:$ANDROID_SDK_ROOT/emulator"
    # PATH="$PATH:$ANDROID_SDK_ROOT/platform-tools"
    # PATH="$PATH:$ANDROID_SDK_ROOT/tools"
    # PATH="$PATH:$ANDROID_SDK_ROOT/tools/bin"
fi

# ## Android platform-tools
# if [ -d "/usr/lib/android-sdk/cmdline-tools" ] && [ -d "/usr/lib/android-sdk/platform-tools" ]; then
#     export ANDROID_HOME="/usr/lib/android-sdk"
#     PATH="$PATH:$ANDROID_HOME/cmdline-tools/bin"
#     PATH="$PATH:$ANDROID_HOME/platform-tools"
# fi

# IntelliJ IDEA
if [ -d "$HOME/.local/share/applications" ]; then
    PATH="$HOME/.local/share/applications:$PATH"
fi

## Imagick
if [ -d "/opt/ImageMagick" ]; then
    export MAGICK_HOME="/opt/ImageMagick"
    export PATH="$MAGICK_HOME/bin:$PATH"
#    PATH="$PATH:/opt/ImageMagick"
    LD_LIBRARY_PATH="${LD_LIBRARY_PATH:+$LD_LIBRARY_PATH:}$MAGICK_HOME/lib"
    export LD_LIBRARY_PATH
fi

## jdk (Java)
if [ -d "/usr/lib/jvm" ]; then
    # JAVA_HOME=$(readlink -f /usr/bin/java | sed "s:bin/java::") # dynamically determine path to jdk
    export JAVA_HOME=$(dirname $(dirname $(readlink -f /usr/bin/java))) # dynamically determine path to jdk
    PATH="${JAVA_HOME}/bin:$PATH" # something like: /usr/lib/jvm/jdk-[VERSION]-oracle-x64/bin
fi

## nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

## PhpStorm
if [ -d "/opt/PhpStorm" ]; then
    PATH="/opt/PhpStorm/bin:$PATH"
fi

## Toolbox
if [ -d "$HOME/.local/share/JetBrains/Toolbox/scripts" ]; then
    PATH="$HOME/.local/share/JetBrains/Toolbox/scripts:$PATH"
fi
