# .bash_aliases

# Command configurations #
## file and dir listing
alias ls='ls --color=auto' # colorize by LS_COLORS in .shared_prompt
alias l='ls -CF'
alias la='ls -a'
alias ll='ls -alF'

# xclip
## copy command output to clipboard (usage: $COMMAND | clip)
alias clip='xclip -selection clipboard'


# DIRs #
## move up dirs
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'

## fast DIR
alias c='cd /mnt/c/'
alias d='cd /mnt/d/'

# for WSL2:
## cd to /mnt/d/Programmierung
alias p='cd /mnt/d/Programmierung'
alias arbeit='cd /mnt/d/Programmierung//Projekte/Arbeit'
alias privat='cd /mnt/d/Programmierung/Projekte/privat'

## cd to _hints_and_settings
alias h_s='cd /mnt/d/Programmierung/_hints_and_settings'

## cd to project: Cardmarket_Scraping
alias p_CM_S='cd /mnt/d/Programmierung/Projekte/privat/Cardmarket_Scraping'

## cd to project: Cardmarket_Data
#alias p_CM_D='cd /mnt/d/Programmierung/Projekte/privat/Jupyter_Notebooks/Cardmarket_Data'

## cd to project: Cardmarket_Data
alias p_cm-d='cd /mnt/d/Programmierung/Projekte/privat/cardmarket-data'

## cd to project: mtg-lich
alias p_mtg-l='cd /mnt/d/Programmierung/Projekte/privat/mtg-lich'

## cd to project: python-utils
alias p_py-ut='cd /mnt/d/Programmierung/Projekte/privat/python-utils'


# GIT SSH key prompt session store PW
alias git_ssh='eval "$(ssh-agent -s)" && ssh-add ~/.ssh/id_ed25519'


# Others #
## Python venv activate
alias s_lv='source lvenv/bin/activate'
alias s_v='source venv/bin/activate'
