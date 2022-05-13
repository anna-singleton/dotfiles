#!/bin/fish
if playerctl status == "No players found"
	echo "NOT PLAYING"
else
	./polybar-now-playing-script
end
