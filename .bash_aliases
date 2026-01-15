# .bash_aliases
### COMMAND CONFIGURATIONS ###

# TERMINAL OUTPUT #
# cat newline to prevent mash into next prompt
cat_with_newline() {
    command cat "$@"
    echo
}

alias cat="cat_with_newline"


# xclip
## copy command output to  clipboard (usage: $COMMAND | clip)
# Check if we are on macOS by looking for the OS uname
clip_output() {
    if command -v pbcopy >/dev/null 2>&1; then
        pbcopy
    elif command -v xclip >/dev/null 2>&1; then
        xclip -selection clipboard
    else
        echo "No clipboard tool found (pbcopy/wl-copy/xclip/xsel)." >&2
        return 1
    fi
}

# clipboard (macOS)
alias clip="clip_output"


# copy last command to clipboard // no alias bc of awk syntax
copy_last_command() {
    # get last history line (fc -ln -1 prints last command)
    last_line=$(command fc -ln -1 2>/dev/null) || return 1

    # optional: normalize whitespace
    trimmed=$(printf '%s\n' "$last_line" | awk '{$1=$1}1')

    # copy to clipboard and print confirmation
    printf '%s\n' "$trimmed" | eval clip
    printf 'Copied:\n%s\n' \""$trimmed"\"
}

alias cplc="copy_last_command"


# usage:
# 1) recall a previous command with ↑, edit it to start with: cpfc <the command you want to copy>
# 2) press Enter --> the text after "cpfc " is copied to clipboard
# Also: you can call `cpfc some text here` and it will copy the arguments directly.
copy_following_command() {
    # If user supplied args when calling cpfc, copy those (simple mode)
    if [ "$#" -gt 0 ]; then
        printf '%s\n' "$*" | eval clip
        printf 'Copied:\n%s\n' \""$*"\"
    fi
}

alias cpfc="copy_following_command"


curl_with_newline() {
    command curl "$@"
    echo
}

alias curl="curl_with_newline"


# Import Mapping messenger
alias im_messenger="php bin/console messenger:consume async -vv"


# go to /home/fabi/Programming/Projects/private/<project> (or to a named project if you pass an argument)
go_to_proj_root() {
  local project="$1"
  if [[ -n $project ]]; then
    cd "/home/fabi/Programming/Projects/private/$project" 2>/dev/null || { echo "No such project: $project"; return 1; }
    return
  fi

  local cur dest
  cur="$(pwd)"
  dest="$(printf '%s' "$cur" | sed -n 's#^\(/home/fabi/Programming/Projects/private/[^/]*\).*#\1#p')"

  if [[ -n $dest ]]; then
    cd "$dest" || return
  else
    echo "Not inside /home/fabi/Programming/Projects/private/<project> (pwd: $cur)"
    return 1
  fi
}

alias proj_root="go_to_proj_root"


# go to /var/www/Projects/<project> (or to a named project if you pass an argument)
go_to_projv_root() {
  local project="$1"
  if [[ -n $project ]]; then
    cd "/var/www/Projects/$project" 2>/dev/null || { echo "No such project: $project"; return 1; }
    return
  fi

  local cur dest
  cur="$(pwd)"
  dest="$(printf '%s' "$cur" | sed -n 's#^\(/var/www/Projects/[^/]*\).*#\1#p')"

  if [[ -n $dest ]]; then
    cd "$dest" || return
  else
    echo "Not inside /var/www/Projects/<project> (pwd: $cur)"
    return 1
  fi
}

alias projv_root="go_to_projv_root" # for listing in 'alias'


# file backup
# create incremental backup next to the original file
backup() {
  if [ "$#" -ne 1 ]; then
    printf 'Usage: bak FILE\n'
    return 2
  fi

  local src="$1"

  # existance & type checks
  if [ ! -e "$src" ]; then
    printf 'bak: source not found: %s\n' "$src" >&2
    return 1
  fi
  if [ -d "$src" ]; then
    printf 'bak: source is a directory (not supported): %s\n' "$src" >&2
    return 1
  fi

  # first candidate: original + .bak
  local candidate="${src}.bak"

  # if free, copy and return
  if [ ! -e "$candidate" ]; then
    cp -a -- "$src" "$candidate" && printf 'Backup created: %s\n' "$candidate"
    return $?
  fi

  # otherwise find next available numbered backup: file1.bak, file2.bak ...
  local n=1
  while : ; do
    candidate="${src}${n}.bak"
    if [ ! -e "$candidate" ]; then
      cp -a -- "$src" "$candidate" && printf 'Backup created: %s\n' "$candidate"
      return $?
    fi
    n=$((n + 1))
    # safety cap to avoid infinite loop
    if [ "$n" -gt 10000 ]; then
      printf 'bak: failed to find free backup name after 10000 attempts\n' >&2
      return 3
    fi
  done
}

alias bak="backup" # for listing in 'alias'
#####


# file and dir listing
# colorize by LS_COLORS in dotfiles/load/shared_prompt.sh
OS=$(uname)
if [ "$OS" = "Darwin" ]; then
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

# PHP
alias php_cc="php bin/console cache:clear"

# Python
alias py3="python3"
alias py3.12="python3.12"
alias python="python3"

# upgradable
alias uga="apt list --upgradable"
alias upgradable="apt list --upgradable"



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
## general
alias Documents="cd $HOME/Documents"
alias Downloads="cd $HOME/Downloads"
alias Music="cd $HOME/Music"
alias Pictures="cd $HOME/Pictures"
alias Programming="cd $HOME/Programming"
alias Screenshots="cd $HOME/Screenshots"
alias Videos="cd $HOME/Videos"

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

## work
alias work="cd $HOME/Programming/Projects/work"
alias work_customers="cd $HOME/Programming/Projects/work/customers"
alias work_idea="cd $HOME/Programming/Projects/work/IdeaProjects"
alias work_ub="cd ./vendor/studio201/user-backend-bundle/src/Studio201/UserBackendBundle" # only from project root
alias work_php="cd $HOME/Programming/Projects/work/PhpStormProjects"

# GIT SSH key prompt session store PW
alias git_ssh='eval "$(ssh-agent -s)" && ssh-add ~/.ssh/id_ed25519'


# SOURCING #
## ~/.bashrc
alias s_brc="source ~/.bashrc"
alias s_zrc="source ~/.zshrc"

## Python venv activate
alias s_lv="source lvenv/bin/activate"
alias s_v="source venv/bin/activate"
alias s_cv="source bin/activate" # activate in a current venv


# OTHERS #


# root #
if [ "$(whoami)" = "root" ]; then
    alias rm="rm -i"
    alias cp="cp -i"
    alias mv="mv -i"
fi
