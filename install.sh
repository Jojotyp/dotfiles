#!/usr/bin/bash
############################
# This script creates symlinks from the home directory to any desired .dotfiles in $HOME/.dotfiles
############################

# .dotfiles directory
dotfiledir="${HOME}/.dotfiles"

# list of files/folders to symlink in ${homedir}
files=(bash_aliases bash_logout bash_profile bash_prompt bashrc gitconfig)

# change to the .dotfiles directory
echo "Changing to the ${dotfiledir} directory"
cd "${dotfiledir}" || exit

# create symlinks (will overwrite old dotfiles)
for file in "${files[@]}"; do
    echo "Creating symlink to $file in home directory."
    ln -sf "${dotfiledir}/.${file}" "${HOME}/.${file}"
done

echo "Installation Complete!"