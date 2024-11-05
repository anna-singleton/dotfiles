export PATH=$PATH:$HOME/opt/

if [ -f ~/.secrets/bw_session ] && [ -n $BW_SESSION ]; then
    export BW_SESSION=$(cat ~/.secrets/bw_session)
fi

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

git_info() {
    branch=$(git branch --show-current 2> /dev/null)
    if [[ $? -eq 0 ]]; then
        if [[ -d ".git" ]]; then
            printf "(GIT:%s) " "$branch"
        elif [[ -e ".git" ]]; then
            gitcontents=$(cat .git)
            if [[ $gitcontents == 'gitdir: ./.bare' ]]; then
                printf "(GIT:BARE) "
            else
                printf "(GIT:%s) " "$branch"
            fi
        else
            printf "(GIT:%s) " "$branch"
        fi
    fi
}

bang() {
    echo -n -e "\a"
}

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# my stuff
alias vi=nvim
alias vim=nvim
alias tm=tmux-go
# alias pacman='sudo pacman'
alias bwgo=". ~/opt/bwgo"
alias gs="git status"
alias gd="git diff"
alias gr="cd \$(git rev-parse --show-toplevel)"
alias gl="git log --oneline"
alias gls="git log --oneline -n 30"

alias pyv=". \$(fzf-py-venv)"

alias ccat="bat -pp"

alias protontricks='flatpak run com.github.Matoking.protontricks'
alias protontricks-launch='flatpak run --command=protontricks-launch com.github.Matoking.protontricks'

alias pretty_csv="sed 's/,/ ,/g' | column -t -s,"

export EDITOR=nvim
export GOOGLE_APPLICATION_CREDENTIALS=/home/anna/.config/gcloud/application_default_credentials.json

eval `keychain --quiet --eval`

export PS1="\[$(tput setaf 10)\]\u@$HOSTNAME \[$(tput setaf 11)\][\W] \[$(tput setaf 9)\]\$(git_info)\[$(tput sgr0)\]-> "
eval "$(direnv hook bash)"
