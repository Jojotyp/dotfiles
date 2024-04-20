#!/usr/bin/bash
############################
# Configure the .env to contain necessary variables for scripts
############################

DOTFILES_DIR="${HOME}/.dotfiles"
env_file="$DOTFILES_DIR/.env"

echo -e "\nCreate .env file through config.sh\n----------------------------------"

if [ ! -f "$env_file" ]; then
    echo "Creating .env skeleton file..."

    read -p "Please enter your Windows Username: " user_input
    echo "You entered: \"$user_input\""

    echo "WINDOWS_USER=$user_input" > "$env_file"

    echo ".env file has been created."
else
    echo ".env file already exists."
fi

echo -e "Finished config.sh\n"