function quickrun
    set -l langs "c" "rust" "rust (backtrace)" "haskell"

    set -l chosen "unset"
        
    if test (count $argv) -eq  1
        if test $argv = "-r"
            set chosen (printf "%s\n" $langs | fzf)
            echo $chosen > .quickrun
        else
            set chosen (cat .quickrun)
        end
    else
        if test -e .quickrun 
            set chosen (cat .quickrun)
        else
            set chosen (printf "%s\n" $langs | fzf)
            echo $chosen > .quickrun
        end
    end
    
    switch $chosen
        case c
            cr
        case "c build"
            make
        case "rust" "rust run"
            cargo run
        case "rust (backtrace)"
            begin; set -lx RUST_BACKTRACE 1; cargo run; end;
        case haskell
            ghci
        case "*"
            echo $chosen " not yet implemented"
    end
    read
end
