#!/bin/sh


#pidof amberol ncspot mpv spotify >/dev/null || exit
#[ -n "$(pgrep ncspot)" ] && player="ncspot"
#[ -n "$(pgrep spotify)" ] && player="spotify"
#[ -n "$(pgrep mpv)" ] && player="mpv"
#[ -n "$(pgrep amberol)" ] && player="amberol"

#[[ "$1" == "-p" ]] && playerctl -p $player play-pause
#
#player_status=$(playerctl -p $player status 2> /dev/null)
#if [ "$player_status" = "Playing" ]; then
#    echo "$(playerctl -p $player metadata artist) - $(playerctl -p $player metadata title)"
#elif [ "$player_status" = "Paused" ]; then
#    echo " $(playerctl -p $player metadata artist) - $(playerctl -p $player metadata title)"
#fi


[[ "$1" == "-p" ]] && playerctl  play-pause

player_status=$(playerctl  status 2> /dev/null)
if [ "$player_status" = "Playing" ]; then
    echo "$(playerctl  metadata artist) - $(playerctl  metadata title)"
elif [ "$player_status" = "Paused" ]; then
    echo " $(playerctl  metadata artist) - $(playerctl  metadata title)"
fi
