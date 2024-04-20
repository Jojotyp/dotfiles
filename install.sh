#!/usr/bin/bash
############################
# This script creates symlinks from the home directory to any desired .dotfiles in $HOME/.dotfiles
############################

DOTFILES_DIR="${HOME}/.dotfiles"
bash "${DOTFILES_DIR}/config.sh"
source "${DOTFILES_DIR}/.env"

echo -e "\nStarting installation through install.sh\n----------------------------------------"

# list of files/folders to symlink in ${homedir}
files=(bash_aliases bash_logout bash_profile bash_prompt bashrc gitconfig)

# change to the .dotfiles directory
echo "Changing to the ${DOTFILES_DIR} directory"
cd "${DOTFILES_DIR}" || exit

# create symlinks (will overwrite old .dotfiles)
for file in "${files[@]}"; do
    echo "Creating symlink to $file in home directory."
    ln -sf "${DOTFILES_DIR}/.${file}" "${HOME}/.${file}"
done

# settings
echo -e "\nGet settings of applications\n============================"

bash ./settings/vscode.sh
bash ./settings/windows_terminal.sh

echo "Installation Complete!"