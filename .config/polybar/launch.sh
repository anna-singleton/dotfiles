#!/bin/bash

killall -q polybar

polybar annabar & disown

echo "polybar launched..."
