#!/usr/bin/bash


# # COPY FILES from WSL2 Linux Ubuntu ~ (home dir) to /mnt/d/Programmierung/_hints_and_settings/settings/Linux/bash/
# ## bash
# ### .bash_aliases, .bash_history, .bash_logout, .bash_profile, .bashrc
wt.exe wsl -e bash -c "cd ~ &&
                       cp -r ./.bash_aliases /mnt/d/Programmierung/_hints_and_settings/settings/Linux/bash/ &&
                       cp -r ./.bash_history /mnt/d/Programmierung/_hints_and_settings/settings/Linux/bash/ &&
                       cp -r ./.bash_logout /mnt/d/Programmierung/_hints_and_settings/settings/Linux/bash/ &&
                       cp -r ./.bash_profile /mnt/d/Programmierung/_hints_and_settings/settings/Linux/bash/ &&
                       cp -r ./.bashrc /mnt/d/Programmierung/_hints_and_settings/settings/Linux/bash/"
