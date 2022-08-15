function tmux-go
    if test (pgrep tmux);
        tmux a;
    else;
        tmux;
    end;
end
