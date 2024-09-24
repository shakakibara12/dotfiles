#!/usr/bin/env bash

#launch sway
#This should always be the last line! So all the env are exported. Or else the theme fucks really hard
# https://www.reddit.com/r/swaywm/comments/r5wfqt/qt_themes_are_messed_up/
# If running from tty1 start sway
#[ "$(tty)" = "/dev/tty1" ] && exec sway

val=$(udevadm info -a -n /dev/dri/card1 | grep boot_vga | rev | cut -c 2)
WLR_DRM_DEVICE=/dev/dri/card$val sway --unsupported-gpu 2>/tmp/sway.log
