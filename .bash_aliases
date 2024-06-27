# .bash_aliases

# Command configurations #
# file and dir listing
# colorize by LS_COLORS in .shared_prompt
OS=$(uname)
if [ "$OS" == "Darwin" ]; then
    alias ls='ls -G'
else
    alias ls='ls --color=auto -v' # colored; sorted: dotfiles -> normal files
fi
# alias ls='ls --color=auto' # colorize by LS_COLORS in .shared_prompt
alias l='ls -CF'
alias la='ls -a'
alias ll='ls -alF'

# history grep of commands
## show commands entered before from .bash_history (usage: hgrep COMMAND)
alias hgrep='history | grep'

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

## fast mounting
alias c='cd /mnt/c/'
alias d='cd /mnt/d/'

# common dirs
alias dotfiles="cd $HOME/.dotfiles"
alias hints="cd $HOME/Programming/hints"
alias proj="cd $HOME/Programming/Projects"
alias projv="cd /var/www/Projects"
alias work="cd $HOME/Programming/Projects/work"
alias private="cd $HOME/Programming/Projects/private"

# GIT SSH key prompt session store PW
alias git_ssh='eval "$(ssh-agent -s)" && ssh-add ~/.ssh/id_ed25519'


# Others #
## Python venv activate
alias s_lv='source lvenv/bin/activate'
alias s_v='source venv/bin/activate'
