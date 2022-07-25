#!/bin/fish

function cr
    if make TARGET_EXEC=a.out
        ./a.out
    end
end
