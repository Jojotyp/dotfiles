#!/usr/bin/bash
############################
# This script creates symlinks from the home directory to any desired .dotfiles in $HOME/.dotfiles
############################

# project has to be "~/.dotfiles" (/home/USER/.dotfiles)
bash "${HOME}/.dotfiles/config.sh"
source "${HOME}/.dotfiles/.env" # from here on out we can reference this project by "DOTFILES_DIR"
source "${DOTFILES_DIR}/load/bash_utils.sh"

echo -e "\nStarting installation through install.sh\n========================================"

# list of files/folders to symlink in ${homedir}
files=(bash_aliases bash_logout bash_profile bash_prompt bashrc nanorc)

# change to the .dotfiles directory
echo "Changing to the ${DOTFILES_DIR} directory"
cd "${DOTFILES_DIR}" || exit

echo ""

# optionally create backup dir of old .dotfiles
if [ ! -d ${HOME}/.dotfiles_bak ]; then
    confirm_default_yes "Create a backup directory \"${HOME}/.dotfiles_bak\"?" && mkdir ${HOME}/.dotfiles_bak
fi

if [ -d ${HOME}/.dotfiles_bak ]; then
    timestamp=$(date +"%Y-%m-%d_%H-%M-%S")
    confirm_default_yes \
        "Create a backup of old .dotfiles in directory \"${HOME}/.dotfiles_bak/${timestamp}\" and copy old files?" \
        && \
        mkdir ${HOME}/.dotfiles_bak/${timestamp}
fi

echo ""

# create symlinks (will overwrite old .dotfiles)
for file in "${files[@]}"; do
    # Check if the backup directory exists and the .dotfile is a regular file
    if [[ -d "${HOME}/.dotfiles_bak/${timestamp}" && -f "${HOME}/.${file}" ]]; then
        echo "Copying old .dotfile \".${file}\" to \"${HOME}/.dotfiles_bak/${timestamp}/\""
        cp -L "${HOME}/.${file}" "${HOME}/.dotfiles_bak/${timestamp}/"
    fi
    echo "Creating symlink to $file in home directory."
    ln -sf "${DOTFILES_DIR}/.${file}" "${HOME}/.${file}"
done

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
read -r -p "Do you want to create \"Programming\" folders (i.e. ~/Programming/Projects) [y/N] " response
if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]
then
    echo "Creating repository folders (if not already existing):"
    mkdir -pv "${HOME}/Programming/own_packages"
    mkdir -pv "${HOME}/Programming/Projects"
    mkdir -pv "${HOME}/Programming/Projects/private"
    mkdir -pv "${HOME}/Programming/Projects/work"
else
    echo "Will not create any 'Programming' folders."
fi

echo -e "\nInstallation Complete!"
