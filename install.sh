#!/usr/bin/env bash
############################
# This script creates symlinks from the home directory to any desired dotfiles in $HOME/dotfiles
############################

# project has to be "~/dotfiles" (/home/USER/dotfiles or on MacOS: /Users/USER/dotfiles)
DIR_DOTFILES="${HOME}/dotfiles"
source "${DIR_DOTFILES}/load/bash_utils.sh"

echo -e "\nStarting installation through install.sh\n========================================"

# list of files/folders to symlink in ${homedir}
files=(bash_aliases bash_logout bash_profile bash_prompt bashrc nanorc zprofile zsh_aliases zsh_prompt zshrc)

# change to the dotfiles directory
echo "Changing to the ${DIR_DOTFILES} directory"
cd "${DIR_DOTFILES}" || exit

echo ""

# optionally create backup dir of old dotfiles
if [ ! -d "${HOME}/dotfiles_bak" ]; then
    confirm_default_yes "Create a backup directory \"${HOME}/dotfiles_bak\"?" && mkdir ${HOME}/dotfiles_bak
fi

if [ -d "${HOME}/dotfiles_bak" ]; then
    timestamp=$(date +"%Y-%m-%d_%H-%M-%S")
    confirm_default_yes \
        "Create a backup of old dotfiles in directory \"${HOME}/dotfiles_bak/${timestamp}\" and copy old files?" \
        && \
        mkdir ${HOME}/dotfiles_bak/${timestamp}
fi

echo ""

# create copies of old dotfiles if we just created a new dir for this as ~/dotfiles_bak
for file in "${files[@]}"; do
    # check if the backup directory exists and the dotfile is a regular file
    if [[ -d "${HOME}/dotfiles_bak/${timestamp}" && -f "${HOME}/.${file}" ]]; then
        echo "Copying old dotfile \".${file}\" to \"${HOME}/dotfiles_bak/${timestamp}/\""
        cp -L "${HOME}/.${file}" "${HOME}/dotfiles_bak/${timestamp}/"
    fi
done

echo ""

# create symlinks (will overwrite old dotfiles)
for file in "${files[@]}"; do
    echo "Creating symlink to $file in home directory."
    ln -sf "${DIR_DOTFILES}/.${file}" "${HOME}/.${file}"
done

echo ""

# create Documents folders
read -r -p "Do you want to create \"Documents\" folders (i.e. ~/Documents/work) [y/N] " response
if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]
then
    echo "Creating ~/Documents folders (if not already existing):"
    mkdir -pv "${HOME}/Documents/Fussball"
    mkdir -pv "${HOME}/Documents/Studium"
    mkdir -pv "${HOME}/Documents/work"
else
    echo "Will not create any \"Documents\" folders."
fi

# create Pictures folders
read -r -p "Do you want to create \"Pictures\" folders (i.e. ~/Pictures/phone) [y/N] " response
if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]
then
    echo "Creating ~/Pictures folders (if not already existing):"
    mkdir -pv "${HOME}/Pictures/logos"
    mkdir -pv "${HOME}/Pictures/memes"
    mkdir -pv "${HOME}/Pictures/phone"
    mkdir -pv "${HOME}/Pictures/vacation"
    mkdir -pv "${HOME}/Pictures/work"
else
    echo "Will not create any \"Pictures\" folders."
fi

# create repository folders
read -r -p "Do you want to create \"Programming\" folders (i.e. ~/Programming/Projects) [y/N] " response
if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]
then
    echo "Creating repository folders (if not already existing):"
    mkdir -pv "${HOME}/Programming/own_packages"
    mkdir -pv "${HOME}/Programming/scripts"
    mkdir -pv "${HOME}/Programming/venvs"
    mkdir -pv "${HOME}/Programming/Projects"
    mkdir -pv "${HOME}/Programming/Projects/private"
    mkdir -pv "${HOME}/Programming/Projects/work"
    mkdir -pv "${HOME}/Programming/Projects/work/customers"
    mkdir -pv "${HOME}/Programming/Projects/work/databaseDumps"
    mkdir -pv "${HOME}/Programming/Projects/work/IdeaProjects"
    mkdir -pv "${HOME}/Programming/Projects/work/s201"
    mkdir -pv "${HOME}/Programming/Projects/work/SymfonyProjects"
else
    echo "Will not create any \"Programming\" folders."
fi

echo ""

# Optionally install the global Codex instructions from the template without
# overwriting an existing personal configuration.
DIR_CODEX="${CODEX_HOME:-${HOME}/.codex}"
codex_setup_available=1

if ! command -v codex >/dev/null 2>&1; then
    echo "Codex is not installed or is not available in PATH."
    codex_setup_available=0
fi

if [ ! -d "${DIR_CODEX}" ]; then
    echo "The Codex configuration directory ${DIR_CODEX} does not exist."
    codex_setup_available=0
fi

if [ "${codex_setup_available}" -eq 1 ]; then
    read -r -p "Do you want to create global Codex instructions at ${DIR_CODEX}/AGENTS.md? [y/N] " response
    if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]; then
        if [ ! -s "${DIR_CODEX}/AGENTS.md" ]; then
            cp "${DIR_DOTFILES}/codex_setup/MACOS_AGENTS.md.dist" "${DIR_CODEX}/AGENTS.md"
            echo "Installed Codex instructions at ${DIR_CODEX}/AGENTS.md"
        else
            echo "Keeping existing Codex instructions at ${DIR_CODEX}/AGENTS.md"
        fi
    else
        echo "Will not create global Codex instructions."
    fi
else
    echo "Skipping global Codex instructions setup."
fi

echo -e "\nInstallation Complete!"
