#!/bin/sh

player=ncspot,spotify
player_status=$(playerctl -p $player status 2> /dev/null)
if [ "$player_status" = "Playing" ]; then
    echo "$(playerctl -p $player metadata artist) - $(playerctl -p $player metadata title)"
elif [ "$player_status" = "Paused" ]; then
    echo " $(playerctl -p $player metadata artist) - $(playerctl -p $player metadata title)"
fi
