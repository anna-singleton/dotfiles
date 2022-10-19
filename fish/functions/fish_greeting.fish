function fish_greeting
  if test ! (cat ~/work/.work-mode) -eq "1";
    fortune -s | cowsay;
    echo ""
  end
  printf "Investing in"
  set_color blue -o
  printf " rare "
  set_color normal
  echo "fish..."
end
