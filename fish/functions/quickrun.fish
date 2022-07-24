function quickrun
    set -l langs "c" "c build" "c run" "rust" "haskell"

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
            echo "c was chosen"
        case "c build"
            echo "c build was chosen"
        case "c run"
            echo "c run was chosen"
        case rust
            echo "rust"
        case haskell
            echo "haskell loading"
        case "*"
            echo $chosen " not yet implemented"
    end
end
