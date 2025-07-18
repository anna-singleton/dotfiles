PATH="$PATH:$HOME/opt/"
PATH="/usr/local/share/dotnet:$PATH"

PROMPT="%F{12}anna@mac %F{9}[%~] %f-> "

source $(brew --prefix)/opt/zsh-vi-mode/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh

alias ls='ls --color=auto'
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'


# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# my stuff
alias vi=nvim
alias vim=nvim
alias tm=tmux-go
alias gs="git status"
alias gd="git diff"
alias gr="cd \$(git rev-parse --show-toplevel)"
alias gl="git log --oneline"
alias gls="git log --oneline -n 30"

alias pyv=". \$(fzf-py-venv)"
alias sshkey="fzf-sshkey"

alias ccat="bat -pp"

alias pretty_csv="sed 's/,/ ,/g' | column -t -s,"

alias fucking="sudo"

export EDITOR=nvim
{% if basic.is_work %}
export GOOGLE_APPLICATION_CREDENTIALS=/home/anna/.config/gcloud/application_default_credentials.json
{% endif %}

eval `keychain --quiet --eval`

# dotnet-suggest shim script for zsh
_dotnet_suggest_complete()
{
    local fullpath=`which ${words[1]}`
    local position line
    read -nl position
    position=$(($position-1))
    read -l line
    line=$(echo "${line}" | sed s/\"/'\\\"'/g)
    local completions=`dotnet-suggest get --executable "$fullpath" --position ${position} -- "${line}"`
    reply=( "${(ps:\n:)completions}" )
}

compctl -K _dotnet_suggest_complete + -f `dotnet-suggest list` &> /dev/null

