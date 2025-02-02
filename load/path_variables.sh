#!/usr/bin/bash
############################
# This script provides PATH variables for .bashrc
############################

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

# include system binaries for user
if [ -d "/usr/local/lib" ]; then
    export PATH="/usr/local/lib:$PATH"
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
