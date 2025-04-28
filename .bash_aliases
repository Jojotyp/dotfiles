# .bash_aliases
### COMMAND CONFIGURATIONS ###

# TERMINAL OUTPUT #
# cat newline to prevent mash into next prompt
cat_with_newline() {
    command cat "$@"
    echo
}

alias cat="cat_with_newline"

# copy last command to clipboard // no alias bc of awk syntax
copy_last_command() {
    command fc -ln -1 | awk '{$1=$1}1' | clip
}

alias cplc="copy_last_command"

# file and dir listing
# colorize by LS_COLORS in dotfiles/load/shared_prompt.sh
OS=$(uname)
if [ "$OS" == "Darwin" ]; then
    alias ls="ls -G"
else
    alias ls="ls --color=auto -v" # colored; sorted: dotfiles -> normal files
fi
# alias ls="ls --color=auto" # colorize by LS_COLORS in dotfiles/load/shared_prompt.sh
alias l="ls -CF"
alias la="ls -a"
alias ll="ls -alF"
alias llsize="ls -alF --sort=size"
alias lldate="ls -alF --sort=time"

# history grep of commands
## show commands entered before from .bash_history (usage: hgrep COMMAND)
alias hgrep="history | grep"

# python
alias py3="python3"
alias py3.12="python3.12"
alias python="python3"

# upgradable
alias uga="apt list --upgradable"
alias upgradable="apt list --upgradable"

# xclip
## copy command output to  clipboard (usage: $COMMAND | clip)
alias clip="xclip -selection clipboard"


# DIRs #
## move up dirs
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ......="cd ../../../../.."
alias .......="cd ../../../../../.."
alias ........="cd ../../../../../../.."
alias .........="cd ../../../../../../../.."
alias ..........="cd ../../../../../../../../.."
alias ...........="cd ../../../../../../../../../.."

# common dirs
alias Documents="cd $HOME/Documents"
alias Downloads="cd $HOME/Downloads"
alias Music="cd $HOME/Music"
alias Pictures="cd $HOME/Pictures"
alias Programming="cd $HOME/Programming"
alias Screenshots="cd $HOME/Screenshots"
alias Videos="cd $HOME/Videos"

alias customers="cd $HOME/Programming/Projects/work/customers"
alias dotfiles="cd $HOME/dotfiles"
alias hints="cd $HOME/Programming/hints"
alias me="cd $HOME/Documents/me"
alias own_packages="cd $HOME/Programming/own_packages"
alias private="cd $HOME/Programming/Projects/private"
alias progr="cd $HOME/Programming"
alias proj="cd $HOME/Programming/Projects"
alias projv="cd /var/www/Projects"
alias scripts="cd $HOME/Programming/scripts"
alias venvs="cd $HOME/Programming/venvs"
alias work="cd $HOME/Programming/Projects/work"
alias work_customers="cd $HOME/Programming/Projects/work/customers"
alias work_idea="cd $HOME/Programming/Projects/work/IdeaProjects"
alias work_php="cd $HOME/Programming/Projects/work/PhpStormProjects"

# GIT SSH key prompt session store PW
alias git_ssh='eval "$(ssh-agent -s)" && ssh-add ~/.ssh/id_ed25519'


# SOURCING #
## ~/.bashrc
alias s_brc="source ~/.bashrc"

## Python venv activate
alias s_lv="source lvenv/bin/activate"
alias s_v="source venv/bin/activate"
alias s_cv="source bin/activate" # activate in a current venv


# OTHERS #


# root #
if [ whoami == "root" ]; then
    alias rm="rm -i"
    alias cp="cp -i"
    alias mv="mv -i"
fi
