#!/bin/sh

player_status=$(playerctl status 2> /dev/null)
if [ "$player_status" = "Playing" ]; then
    playerctl metadata --format "{{artist}} - {{title}}" -F
elif [ "$player_status" = "Paused" ]; then
     playerctl metadata --format " {{artist}} - {{title}}" -F
fi

#if [ "$player_status" = "Playing" ]; then
#    echo "$(playerctl metadata --format "{{artist}} - {{title}}" -F)"
#elif [ "$player_status" = "Paused" ]; then
#    echo " $(playerctl metadata --format "{{artist}} - {{title}}" -F)r
#fi
