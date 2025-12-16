#!/usr/bin/bash
############################
# This script provides git status info in prompt, venv info in prompt and colorization for .bashrc
############################

# Define the prompt_git function for git repository status
prompt_git() {
    local git_status=''
    local branchName=''

    # Check if the current directory is in a Git repository.
    if git rev-parse --is-inside-work-tree &>/dev/null; then
        # Get the status summary.
        local gitSummary=$(git status --porcelain)

        # Check for uncommitted changes in the index, unstaged changes, untracked files, and stashed files.
        [[ -n $(echo "$gitSummary" | grep '^M') ]] && git_status+='+'
        [[ -n $(echo "$gitSummary" | grep '^ M') ]] && git_status+='!'
        [[ -n $(echo "$gitSummary" | grep '^\\?\\?') ]] && git_status+='?'
        [[ $(
            git rev-parse --verify refs/stash &>/dev/null
            echo "${?}"
        ) == '0' ]] && git_status+='$'

        # Get the short symbolic ref or the short SHA for the latest commit.
        branchName="$(git symbolic-ref --quiet --short HEAD 2>/dev/null || git rev-parse --short HEAD 2>/dev/null || echo '(unknown)')"

        [ -n "${git_status}" ] && git_status=" [${git_status}]"
        # ➔ →
        printf "%b → %b%s%s" "${color_white}" "${color_blue}" "${branchName}" "${git_status}"
    else
        return
    fi
}

export VIRTUAL_ENV_DISABLE_PROMPT=1
prompt_venv() {
    # check for Python venv
    if [[ -n "$VIRTUAL_ENV" ]]; then
        # Extract the last directory name in the $VIRTUAL_ENV path
        venv_name=$(basename "$VIRTUAL_ENV")
        printf "%b(%s) \n" "${color_steel_blue}" "${venv_name}"
    fi
}

# Using tput for colors and formatting.
tput sgr0 # reset colors
bold=$(tput bold)
reset_styles=$(tput sgr0)

# see color codes at: https://en.wikipedia.org/wiki/ANSI_escape_code#8-bit
color_blue=$(tput setaf 27)
color_blue2=$(tput setaf 75)
color_gold=$(tput setaf 220)
color_green=$(tput setaf 28)
color_neon_blue=$(tput setaf 123)
color_steel_blue=$(tput setaf 67)
color_red=$(tput setaf 196)
color_orange=$(tput setaf 166)
color_yellow=$(tput setaf 229)
color_white=$(tput setaf 255)

# Colorize the ls -a command #
# directories (di): color_yellow
# executables (ex): color_green
# files (fi): color_blue2
# symbolic links (ln): color_neon_blue
# symbolic links pointing to non-existent files (or -> orphaned): color_red)
# Check if we are on macOS by looking for the OS uname
OS=$(uname)
if [ "$OS" = "Darwin" ]; then
    export CLICOLOR=1
    # export LSCOLORS="ExGxCxDxCxegecabagacad"
    export LSCOLORS="exfxcxdxbxegedabagacad"
else
    unset LS_COLORS
    export LS_COLORS='di=38;5;27:ex=38;5;28:fi=38;5;255:ln=38;5;123:or=38;5;167'
fi

# Highlight the user name when logged in as root.
if [[ "${USER}" == "root" ]]; then
    userStyle="${bold}${color_red}"
else
    userStyle="${color_gold}"
fi

# Highlight the hostname when connected via SSH.
if [[ "${SSH_TTY}" ]]; then
    hostStyle="${color_red}"
else
    hostStyle="${color_gold}"
fi
