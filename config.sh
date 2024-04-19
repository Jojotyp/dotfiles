#!/usr/bin/bash
############################
# Configure the .env to contain necessary variables for scripts
############################

dotfiles_dir=$(dirname $(readlink -f "$0"))

env_file="$dotfiles_dir/.env"

if [ ! -f "$env_file" ]; then
    echo "Creating .env skeleton file..."

    echo "DOTFILES_DIR=${dotfiles_dir}" > "$env_file"
    echo "WINDOWS_USER=YOUR_USERNAME" >> "$env_file"

    echo ".env file has been created with default values. Please update it accordingly."
else
    echo ".env file already exists."
fi

# TODO: optinally set variables here by QA