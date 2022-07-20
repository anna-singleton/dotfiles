function fish_greeting
  fortune -s | cowsay
  echo ""
  printf "Investing in"
  set_color blue -o
  printf " rare "
  set_color normal
  echo "fish..."
end
