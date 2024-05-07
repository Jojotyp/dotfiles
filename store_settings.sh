#!/usr/bin/bash
############################
# This script stores settings of applications to ${HOME}/.dotfiles/settings/
############################

source "${HOME}/.dotfiles/.env"
source "${DOTFILES_DIR}/bash_utils.sh"

# settings
echo -e "\nSave local settings of applications\n==================================="
promptSettings="Are you sure that you want to get local settings of"
settingsFetched="Settings were fetched successfully."
settingsNotFetched="Settings were NOT fetched."

promptSettingsVsCode=""$promptSettings" VS Code?"
promptSettingsWindowsTerminal=""$promptSettings" Windows Terminal?"

confirm "$promptSettingsVsCode" && bash ./settings/vscode.sh
confirm "$promptSettingsWindowsTerminal" && bash ./settings/windows_terminal.sh
