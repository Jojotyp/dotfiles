#!/usr/bin/bash
############################
# This script creates settings for a specific application.
############################

DOTFILES_DIR="${HOME}/.dotfiles"
source "${DOTFILES_DIR}/.env"

application_name="windows_terminal"

echo "settings/${application_name}.sh:"

# Check if we are on WSL by looking for the presence of "microsoft" in the kernel name
if grep -qi microsoft /proc/version; then
    echo "Running on WSL2. Proceeding with copy operation."

    mkdir -p "$DOTFILES_DIR/settings/${application_name}"

    # assume the path
    resolved_path=$(find "/mnt/c/Users/$WINDOWS_USER/AppData/Local/Packages/" -type d -name "Microsoft.WindowsTerminal*" -print -quit)
    settings_src="${resolved_path}/LocalState/settings.json"

    cp "$settings_src" "$DOTFILES_DIR/settings/${application_name}/settings.json"

    echo "Copy operation completed."
else
    echo "Not running on WSL2. Script will exit."
fi

echo ""