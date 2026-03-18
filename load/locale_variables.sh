#!/usr/bin/bash
############################
# This script provides locale variables for .bashrc
############################

# Only export locale values that are available on the current machine.
# This avoids "Setting locale failed" warnings on servers with a smaller
# locale set while keeping the preferred mixed en_US/de_DE setup where possible.

set_locale_var() {
    local var_name="$1"
    local preferred="$2"
    local fallback="$3"
    local chosen=""

    if [ "$(uname -s)" = "Darwin" ]; then
        chosen="$preferred"
    elif command -v locale >/dev/null 2>&1; then
        if locale -a 2>/dev/null | grep -Fxq "$preferred"; then
            chosen="$preferred"
        elif [ -n "$fallback" ] && locale -a 2>/dev/null | grep -Fxq "$fallback"; then
            chosen="$fallback"
        fi
    fi

    [ -n "$chosen" ] && export "$var_name=$chosen"
}

# macOS uses UTF-8, Linux typically exposes utf8.
if [ "$(uname -s)" = "Darwin" ]; then
    lang_locale="en_US.UTF-8"
    de_locale="de_DE.UTF-8"
    fallback_locale="C.UTF-8"
else
    lang_locale="en_US.utf8"
    de_locale="de_DE.utf8"
    fallback_locale="C.utf8"
fi

set_locale_var LANG "$lang_locale" "$fallback_locale"
set_locale_var LC_CTYPE "$lang_locale" "$fallback_locale"
set_locale_var LC_NUMERIC "$de_locale" "$fallback_locale"
set_locale_var LC_TIME "$de_locale" "$fallback_locale"
set_locale_var LC_COLLATE "$lang_locale" "$fallback_locale"
set_locale_var LC_MONETARY "$de_locale" "$fallback_locale"
set_locale_var LC_MESSAGES "$lang_locale" "$fallback_locale"
set_locale_var LC_PAPER "$de_locale" "$fallback_locale"
set_locale_var LC_NAME "$lang_locale" "$fallback_locale"
set_locale_var LC_ADDRESS "$lang_locale" "$fallback_locale"
set_locale_var LC_TELEPHONE "$lang_locale" "$fallback_locale"
set_locale_var LC_MEASUREMENT "$de_locale" "$fallback_locale"
set_locale_var LC_IDENTIFICATION "$lang_locale" "$fallback_locale"

unset lang_locale
unset de_locale
unset fallback_locale
