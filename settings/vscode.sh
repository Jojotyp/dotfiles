#!/usr/bin/bash
############################
# This script creates symlinks from the home directory to any desired .dotfiles in $HOME/.dotfiles
############################

source "$(dirname $(readlink -f "$0"))/../.env"

echo $DOTFILES_DIR

# # Check if we are on WSL by looking for the presence of "microsoft" in the kernel name
# if grep -qi microsoft /proc/version; then
#     echo "Running on WSL2. Proceeding with copy operation."

#     # Ensure the destination directory exists
#     mkdir -p "$DOTFILES_DIR"

#     # Define the source paths on your Windows filesystem.
#     windows_user="Fabi"
#     settings_src="/mnt/c/Users/$windows_user/AppData/Roaming/Code/User/settings.json"
#     keybindings_src="/mnt/c/Users/$windows_user/AppData/Roaming/Code/User/keybindings.json"

#     # Copy the files to the destination directory
#     cp "$settings_src" "$DOTFILES_DIR/settings/vscode/settings.json"
#     cp "$keybindings_src" "$DOTFILES_DIR/settings/vscode/keybindings.json"

#     echo "Copy operation completed."
# else
#     echo "Not running on WSL2. Script will exit."
# fi