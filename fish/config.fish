if status is-interactive
    alias pacman "sudo pacman"
    alias cl "clear"
    alias ls "ls -l --color=auto"
    alias ll "ls -lah"
    alias nt "ping 8.8.8.8"
    alias emacs-kill "emacsclient --eval '(kill-emacs)'"
    alias emacs-start "emacs --daemon"
    alias emacs-restart "emacs-kill; emacs-start"
end

thefuck --alias | source

# if test -z (pgrep ssh-agent)
#   eval (ssh-agent -c)
#   set -Ux SSH_AUTH_SOCK $SSH_AUTH_SOCK
#   set -Ux SSH_AGENT_PID $SSH_AGENT_PID
#   set -Ux SSH_AUTH_SOCK $SSH_AUTH_SOCK
# end

# ruby gem stuff (ffs)
set -Ux GEM_HOME "$(ruby -e 'puts Gem.user_dir')"
set PATH $PATH:$GEM_HOME/bin
