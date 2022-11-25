function tmux-go
    if test (pgrep tmux);
        tmux a;
    else;
        tmux new-session -c ~;
    end;
end
