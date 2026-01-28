#!/usr/bin/bash
############################
# This script provides locale variables for .bashrc
############################

# set locale

# macOS
if [ "$(uname -s)" = "Darwin" ]; then
    export LANG="en_US.UTF-8"
    export LC_CTYPE="en_US.UTF-8"
    export LC_NUMERIC="de_DE.UTF-8"
    export LC_TIME="de_DE.UTF-8"
    export LC_COLLATE="en_US.UTF-8"
    export LC_MONETARY="de_DE.UTF-8"
    export LC_MESSAGES="en_US.UTF-8"
    export LC_PAPER="de_DE.UTF-8"
    export LC_NAME="en_US.UTF-8"
    export LC_ADDRESS="en_US.UTF-8"
    export LC_TELEPHONE="en_US.UTF-8"
    export LC_MEASUREMENT="de_DE.UTF-8"
    export LC_IDENTIFICATION="en_US.UTF-8"
    # export LC_ALL="en_US.UTF-8"
# Linux
else
    export LANG="en_US.utf8"
    export LC_CTYPE="en_US.utf8"
    export LC_NUMERIC="de_DE.utf8"
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
    # export LC_ALL="en_US.utf8"
fi
