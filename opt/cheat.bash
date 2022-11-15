#!/usr/bin/env bash

if ! hash cht.sh &> /dev/null; then
    echo "cht.sh not installed, installing in /usr/local/bin/."
    PATH_DIR="/usr/local/bin"  # or another directory on your $PATH
    mkdir -p "$PATH_DIR"
    curl https://cht.sh/:cht.sh | sudo tee "$PATH_DIR/cht.sh"
    sudo chmod +x "$PATH_DIR/cht.sh"
fi

echo "enter query for cht.sh"
read -r args

cht.sh "$args" | less -r
