function info
    printf "%s " (fish_git_prompt)
end

function fish_prompt
  set_color white -o
  printf "anna"
  set_color normal
  set_color green
  printf " [%s] " (basename $PWD)
  set_color 7ACBF5
  printf "█"
  set_color EAACB8
  printf "█"
  set_color FFFFFF
  printf "█"
  set_color EAACB8
  printf "█"
  set_color 7ACBF5
  printf "█"
  set_color red -o
  printf "%s " (fish_git_prompt)
  set_color normal
  set_color white
  printf "><> "
end

