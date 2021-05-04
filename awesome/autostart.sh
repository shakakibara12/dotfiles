#!/bin/bash

function run {
  if ! pgrep $1 ;
  then
    $@&
  fi
}
#run dex $HOME/.config/autostart/arcolinux-welcome-app.desktop
#run xrandr --output VGA-1 --primary --mode 1360x768 --pos 0x0 --rotate normal
#run xrandr --output HDMI2 --mode 1920x1080 --pos 1920x0 --rotate normal --output HDMI1 --primary --mode 1920x1080 --pos 0x0 --rotate normal --output VIRTUAL1 --off
run nm-applet
#run caffeine
#run pamac-tray
#run variety
run nitrogen --restore
#run xfce4-power-manager
run copyq
#run pulseeffects -l epic --gapplication-service
#run blueberry-tray
run /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1
run indicator-sound-switcher
#run numlockx on
#run volumeicon
#run conky -c $HOME/.config/awesome/system-overview
#you can set wallpapers in themes as well
#feh --bg-fill /usr/share/backgrounds/arcolinux/blue-earth-2880x1800.jpg &
#run applications from startup
#run firefox
#run atom
#run dropbox
#run insync start
#run spotify
#run ckb-next -b
#run discord
#run telegram-desktop
run xfce4-clipman
