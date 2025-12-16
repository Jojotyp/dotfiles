#!/usr/bin/env zsh

# Exit if the shell is non-interactive.
[[ -o interactive ]] || return

# History behavior similar to bash configuration.
setopt APPEND_HISTORY
HISTSIZE=1000
SAVEHIST=10000

# Load aliases and prompt customizations.
for file in ~/.{zsh_aliases,zsh_prompt}; do
    [[ -r "$file" ]] && [[ -f "$file" ]] && source "$file"
done
unset file

# Load locale and PATH variables shared with bash.
for file in ~/dotfiles/load/{locale_variables,path_variables}; do
    [[ -r "${file}.sh" ]] && source "${file}.sh"
done
unset file
