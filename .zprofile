emulate sh
source ~/.profile
emulate zsh

# .zprofile

# call .zshrc to syncronize
if [ -f ~/.zshrc ]; then
	source ~/.zshrc
fi
