#!/usr/bin/bash
############################
# This script provides PATH variables for .bashrc

# to prepend to PATH
## PATH="$[VAR]/[REST_PATH]:$PATH"

# to append to PATH
## PATH="$PATH:$[VAR]/[REST_PATH]
############################

# Set Flatpak application paths to show them in desktop environment
if [ -z "${XDG_DATA_DIRS-}" ]; then
    XDG_DATA_DIRS="/usr/local/share:/usr/share"
fi
XDG_DATA_DIRS="/var/lib/flatpak/exports/share:${XDG_DATA_DIRS}"
XDG_DATA_DIRS="${HOME}/.local/share/flatpak/exports/share:${XDG_DATA_DIRS}"
export XDG_DATA_DIRS


# PATH & OTHER VARIABLES #
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
# Android SDK (Linux: ~/Android/Sdk, macOS: ~/Library/Android/sdk)
_android_sdk=""
for d in "$HOME/Android/Sdk" "$HOME/Library/Android/sdk"; do
  if [ -d "$d" ]; then
    _android_sdk="$d"
    break
  fi
done

if [ -n "$_android_sdk" ]; then
  export ANDROID_HOME="$_android_sdk"
  export ANDROID_SDK_ROOT="$_android_sdk"

  # Add to PATH only if the directory exists
  [ -d "$ANDROID_HOME/platform-tools" ] && export PATH="$PATH:$ANDROID_HOME/platform-tools"
  [ -d "$ANDROID_HOME/emulator" ] && export PATH="$PATH:$ANDROID_HOME/emulator"

  # cmdline-tools: prefer latest, but also accept a versioned folder
  if [ -d "$ANDROID_HOME/cmdline-tools/latest/bin" ]; then
    export PATH="$PATH:$ANDROID_HOME/cmdline-tools/latest/bin"
  else
    # pick first versioned cmdline-tools directory if present
    for v in "$ANDROID_HOME/cmdline-tools"/*/bin; do
      [ -d "$v" ] && export PATH="$PATH:$v" && break
    done
  fi
fi

unset _android_sdk


# ## Android platform-tools
# if [ -d "/usr/lib/android-sdk/cmdline-tools" ] && [ -d "/usr/lib/android-sdk/platform-tools" ]; then
#     export ANDROID_HOME="/usr/lib/android-sdk"
#     export PATH="$PATH:$ANDROID_HOME/cmdline-tools/bin"
#     export PATH="$PATH:$ANDROID_HOME/platform-tools"
# fi

## Homebrew (macOS)
if [ -x /opt/homebrew/bin/brew ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

## Cargo (Rust)
if [ -f "$HOME/.cargo/env" ]; then 
    . "$HOME/.cargo/env"
fi

## Google Chrome / Microsoft Edge (Linux + macOS)
# --- Linux (your Flatpak wrapper) ---
if [ -x "/usr/local/bin/google-chrome-flatpak" ]; then
  export CHROME_PATH="/usr/local/bin/google-chrome-flatpak"
  export EDGE_PATH="/usr/local/bin/google-chrome-flatpak"
fi

# --- macOS ---
# Prefer Chrome, fall back to Edge if you want
if [ -z "${CHROME_PATH:-}" ]; then
  if [ -x "/Applications/Google Chrome.app/Contents/MacOS/Google Chrome" ]; then
    export CHROME_PATH="/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"
  elif [ -x "$HOME/Applications/Google Chrome.app/Contents/MacOS/Google Chrome" ]; then
    export CHROME_PATH="$HOME/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"
  fi
fi

if [ -z "${EDGE_PATH:-}" ]; then
  if [ -x "/Applications/Microsoft Edge.app/Contents/MacOS/Microsoft Edge" ]; then
    export EDGE_PATH="/Applications/Microsoft Edge.app/Contents/MacOS/Microsoft Edge"
  elif [ -x "$HOME/Applications/Microsoft Edge.app/Contents/MacOS/Microsoft Edge" ]; then
    export EDGE_PATH="$HOME/Applications/Microsoft Edge.app/Contents/MacOS/Microsoft Edge"
  fi
fi

# Optional: provide `google-chrome` command on macOS (handy for scripts)
# (Symlink is cleaner, but alias works without admin rights)
if [ -n "${CHROME_PATH:-}" ]; then
  alias google-chrome="\"$CHROME_PATH\""
fi


## IntelliJ IDEA
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

## JDK (Java) - Linux + macOS
# Prefer JDK 17 if available (Android/Gradle friendly)
if command -v /usr/libexec/java_home >/dev/null 2>&1; then
  # macOS (Temurin installs into /Library/Java/JavaVirtualMachines)
  _JAVA_HOME="$(/usr/libexec/java_home -v 17 2>/dev/null || /usr/libexec/java_home 2>/dev/null)"
  if [ -n "$_JAVA_HOME" ] && [ -d "$_JAVA_HOME" ]; then
    export JAVA_HOME="$_JAVA_HOME"
    export PATH="$JAVA_HOME/bin:$PATH"
  fi
  unset _JAVA_HOME

elif [ -d "/usr/lib/jvm" ]; then
  # Linux (common layouts)
  if command -v readlink >/dev/null 2>&1 && [ -x /usr/bin/java ]; then
    _JAVA_BIN="$(readlink -f /usr/bin/java 2>/dev/null)"
    if [ -n "$_JAVA_BIN" ]; then
      export JAVA_HOME="$(dirname "$(dirname "$_JAVA_BIN")")"
      export PATH="$JAVA_HOME/bin:$PATH"
    fi
    unset _JAVA_BIN
  fi
fi


## nvm
## nvm (Linux + macOS/Homebrew)
export NVM_DIR="$HOME/.nvm"
[ -d "$NVM_DIR" ] || mkdir -p "$NVM_DIR"

# 1) Prefer "classic" install (common on Linux): ~/.nvm/nvm.sh
if [ -s "$NVM_DIR/nvm.sh" ]; then
  . "$NVM_DIR/nvm.sh"
  [ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"

# 2) Fallback: Homebrew install (common on macOS)
elif command -v brew >/dev/null 2>&1; then
  _NVM_BREW_PREFIX="$(brew --prefix nvm 2>/dev/null)"

  if [ -n "$_NVM_BREW_PREFIX" ] && [ -s "$_NVM_BREW_PREFIX/nvm.sh" ]; then
    . "$_NVM_BREW_PREFIX/nvm.sh"

    # optional completion (works fine in zsh)
    [ -s "$_NVM_BREW_PREFIX/etc/bash_completion.d/nvm" ] && . "$_NVM_BREW_PREFIX/etc/bash_completion.d/nvm"
  fi

  unset _NVM_BREW_PREFIX
fi

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
