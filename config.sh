#!/usr/bin/bash
############################
# Configure the .env to contain necessary variables for scripts
############################

env_file="${HOME}/.dotfiles/.env"

echo -e "\nCreate .env file through config.sh\n----------------------------------"

if [ ! -f "$env_file" ]; then
    echo "Creating .env skeleton file..."

    echo "DOTFILES_DIR=${HOME}/.dotfiles" > "$env_file"
    echo "Created .env \$DOTFILES_DIR variable: $DOTFILES_DIR"

    if grep -qi microsoft /proc/version; then
        echo "Running on WSL2. Proceeding with copy operation."
        read -p "Please enter your Windows Username: " user_input
        echo "You entered: \"$user_input\""

        echo "WINDOWS_USER=$user_input" > "$env_file"
        echo "Created .env \$WINDOWS_USER variable: $WINDOWS_USER"
    fi

    echo ".env file has been created."
else
    echo ".env file already exists."
fi

echo -e "Finished config.sh\n"