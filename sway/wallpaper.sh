#!/bin/sh

path=$HOME/Pictures/Wallpapers
choose=$(sxiv -r -t -q -o $path)

[[ -d $HOME/Pictures/Wallpapers ]] || mkdir -p $Home/Pictures/Wallpapers/

[[ -z $choose ]] || ln -sf $choose $path/wallpaper && pkill swaybg ; swaybg -i $path/wallpaper -m fill
exit

