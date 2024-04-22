#!/usr/bin/bash
############################
# This script stores settings of applications to ${HOME}/.dotfiles/settings/
############################

confirm() {
    # call with a prompt string or use a default
    read -r -p "${1:-Are you sure?} [y/N] " response
    case "$response" in
        [yY][eE][sS]|[yY]) 
            true
            ;;
        *)
            false
            ;;
    esac
}


# settings
echo -e "\nSave local settings of applications\n==================================="
promptSettings="Are you sure that you want to get local settings of"
settingsFetched="Settings were fetched successfully."
settingsNotFetched="Settings were NOT fetched."

promptSettingsVsCode=""$promptSettings" VS Code?"
promptSettingsWindowsTerminal=""$promptSettings" Windows Terminal?"

confirm "$promptSettingsVsCode" && bash ./settings/vscode.sh
confirm "$promptSettingsWindowsTerminal" && bash ./settings/windows_terminal.sh
