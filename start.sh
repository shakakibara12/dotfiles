#!/usr/bin/env bash

export XDG_CURRENT_DESKTOP=sway
#launch sway
#This should always be the last line! So all the env are exported. Or else the theme fucks really hard
# https://www.reddit.com/r/swaywm/comments/r5wfqt/qt_themes_are_messed_up/
# If running from tty1 start sway
#[ "$(tty)" = "/dev/tty1" ] && exec sway

WLR_DRM_DEVICE=/dev/dri/card0 sway --unsupported-gpu 2>/tmp/sway.log
#Hyprland
