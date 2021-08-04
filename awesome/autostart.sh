#!/bin/bash

function run {
  if ! pgrep $1 ;
  then
    $@&
  fi
}
#run caffeine
#run pamac-tray
#run variety
run nitrogen --restore
run copyq
#run xfce4-clipman
run nm-applet
#run blueberry-tray
run /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1
run numlockx on
run xbindkeys -p
#run ~/scripts/wine.sh
#run ~/Downloads/styli.sh/styli.sh -s landscape
#run pulseeffects -l epic --gapplication-service
#run kdeconnect-indicator
run indicator-sound-switcher
#run volumeicon
#run conky -c $HOME/.config/awesome/system-overview
#you can set wallpapers in themes as well
#feh --bg-fill /usr/share/backgrounds/arcolinux/blue-earth-2880x1800.jpg &
#run firefox
#run atom
#run spotify
#run ckb-next -b
#run discord
#run telegram-desktop
