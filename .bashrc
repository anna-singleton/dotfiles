# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'

# custom bash output
outofdate()
{
	echo $(cat /home/anna/.util/outofdatepackages)
}

RED="\[$(tput setaf 1)\]"
GREEN="\[$(tput setaf 2)\]"
BOLD="\[$(tput bold)\]"
RESET="\[$(tput sgr0)\]"

PS1="${BOLD}anna ${RESET}${GREEN}[\W] ${RESET}${RED}${BOLD}"'($(outofdate))'"${RESET} >"

# ssh-keychain

eval $(keychain --eval --nogui --quiet ~/.ssh/github)

# BEGIN_KITTY_SHELL_INTEGRATION
if test -n "$KITTY_INSTALLATION_DIR" -a -e "$KITTY_INSTALLATION_DIR/shell-integration/bash/kitty.bash"; then source "$KITTY_INSTALLATION_DIR/shell-integration/bash/kitty.bash"; fi
# END_KITTY_SHELL_INTEGRATION
