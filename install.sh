#!/usr/bin/bash
############################
# This script creates symlinks from the home directory to any desired .dotfiles in $HOME/.dotfiles
############################

# project has to be "~/.dotfiles" (/home/USER/.dotfiles)
bash "${HOME}/.dotfiles/config.sh"
source "${HOME}/.dotfiles/.env" # from here on out we can reference this project by "DOTFILES_DIR"
source "${DOTFILES_DIR}/bash_utils.sh"

echo -e "\nStarting installation through install.sh\n========================================"

# list of files/folders to symlink in ${homedir}
files=(bash_aliases bash_logout bash_profile bash_prompt bashrc)

# change to the .dotfiles directory
echo "Changing to the ${DOTFILES_DIR} directory"
cd "${DOTFILES_DIR}" || exit

# create symlinks (will overwrite old .dotfiles)
for file in "${files[@]}"; do
    echo "Creating symlink to $file in home directory."
    ln -sf "${DOTFILES_DIR}/.${file}" "${HOME}/.${file}"
done

echo ""

# .gitconfig
read -r -p "Are you on a work PC? (to fetch correct .gitconfig) [y/N] " response
if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]
then
    echo "Copying work .gitconfig."
    cp "${DOTFILES_DIR}/work/.gitconfig" "${HOME}/.gitconfig"
else
    echo "Copying private .gitconfig."
    cp "${DOTFILES_DIR}/.gitconfig" "${HOME}/.gitconfig"
fi

# create repository folders
read -r -p "Do you want to create repository folders (i.e. ~/Programming/Projects) [y/N] " response
if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]
then
    echo "Creating repository folders (if not already existing):"
    mkdir -pv "${HOME}/Programming/Projects"
    mkdir -pv "${HOME}/Programming/Projects/private"
    mkdir -pv "${HOME}/Programming/Projects/work"
else
    echo "No repository folders created."
fi

echo -e "\nInstallation Complete!"