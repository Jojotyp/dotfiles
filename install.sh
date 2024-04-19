#!/usr/bin/bash
############################
# This script creates symlinks from the home directory to any desired .dotfiles in $HOME/.dotfiles
############################

bash "$(dirname $(readlink -f "$0"))/config.sh"
source "$(dirname $(readlink -f "$0"))/.env"

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

# TODO: 

echo "Installation Complete!"