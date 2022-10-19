function dir
    set d $(basename $PWD)
    if test $d = $USER; printf "~";
    else; printf "%s" $d;
    end
end

function fish_prompt
  set_color white -o
  printf "anna"
  set_color normal
  set_color green
  printf " [%s]" (dir)
  set_color red -o
  printf "%s " (fish_git_prompt)
  set_color normal
  set_color white
  if test ! (cat ~/work/.work-mode) -eq "1";
    set_color 7ACBF5
    printf "█"
    set_color EAACB8
    printf "█"
    set_color FFFFFF
    printf "█"
    set_color EAACB8
    printf "█"
    set_color 7ACBF5
    printf "█ ";
  else
    set_color blue
    printf "w "
  end
  set_color normal
  set_color white
  printf "><> "
end

