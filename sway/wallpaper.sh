#!/bin/bash

# Load Xresources if not already loaded
if [[ -z $(xrdb -query) ]]; then
    xrdb "$HOME/.Xdefaults"
fi

# Function to set wallpaper from images
set_wallpaper() {
    local path1="$HOME/Pictures/Wallpapers"
    local choose=$(nsxiv -r -t -q -o "$path1")

    # Exit if no image is selected
    if [[ -z "$choose" ]]; then
        exit 0
    fi

    # Create the wallpaper directory if it doesn't exist
    #mkdir -p "$path1"

    # Check the number of selected images
    local line_count=$(echo "$choose" | wc -l)

    if (( line_count > 1 )); then
        local first_wall=$(echo "$choose" | sed -n '1p')
        local second_wall=$(echo "$choose" | sed -n '2p')
        ln -sf "$first_wall" "$path1/wallpaper"
        ln -sf "$second_wall" "$path1/wallpaper2"
    else
        ln -sf "$choose" "$path1/wallpaper"
    fi

    # Restart swaybg with the new wallpapers
    pkill swaybg
    swaybg -o eDP-1 -i "$path1/wallpaper" -m fill &
    swaybg -o HDMI-A-1 -i "$path1/wallpaper2" -m fill &
}

# Function to set wallpaper from videos
set_video_wallpaper() {
    pidof "mpvpaper" && pkill mpvpaper > /dev/null
    local path2="$HOME/Downloads/Vid_wallpapers"
    local video=$(ls "$path2" | shuf -n 1)
    mpvpaper -f -p -o "hwdec=auto panscan=1 no-audio loop" eDP-1 "$path2/$video" > /dev/null
}

# Main script execution
case "$1" in
    -v) set_video_wallpaper ;;
    -w) set_wallpaper ;;
    *) echo "Usage: $0 [-v | -w]" ;;
esac

