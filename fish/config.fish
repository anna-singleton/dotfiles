if status is-interactive
    alias pacman "sudo pacman"
    alias cl "clear"
    alias ls "ls -lh --color=auto"
    alias ll "ls -lah"
    alias nt "ping 8.8.8.8"
    alias vi nvim
    alias vim nvim
    alias emacs-kill "emacsclient --eval '(kill-emacs)'"
    alias emacs-start "emacs --daemon"
    alias emacs-restart "emacs-kill; emacs-start"
    alias tm "tmux-go"
    alias kittyfixssh "kitty +kitten ssh"
    alias sshg "/home/anna/work/sshg"
end

thefuck --alias | source

# if test -z (pgrep ssh-agent)
#   eval (ssh-agent -c)
#   set -Ux SSH_AUTH_SOCK $SSH_AUTH_SOCK
#   set -Ux SSH_AGENT_PID $SSH_AGENT_PID
#   set -Ux SSH_AUTH_SOCK $SSH_AUTH_SOCK

fish_add_path $HOME/opt

# ruby gem stuff (ffs)
set -Ux GEM_HOME "$(ruby -e 'puts Gem.user_dir')"
fish_add_path $GEM_HOME/bin

set -q GHCUP_INSTALL_BASE_PREFIX[1]; or set GHCUP_INSTALL_BASE_PREFIX $HOME ; fish_add_path $HOME/.cabal/bin ; fish_add_path -a /home/anna/.ghcup/bin # ghcup-env
