#!/bin/bash

waylogout \
    --hide-cancel \
    --fade-in 3 \
    --screenshots \
    --font="Roboto Medium" \
    --effect-blur=7x5 \
    --indicator-thickness=10 \
    --ring-color=888888aa \
    --inside-color=1a1a1aff  \
    --text-color=eaeaeaaa \
    --line-color=00000000 \
    --ring-selection-color=ff5500aa \
    --inside-selection-color=1a1a1aff \
    --text-selection-color=eaeaeaaa \
    --line-selection-color=00000000 \
    --lock-command="/usr/bin/swaylock" \
    --logout-command="/usr/bin/swaymsg exit" \
    --suspend-command="/usr/bin/systemctl suspend" \
    --poweroff-command="/sbin/shutdown -a now" \
    --reboot-command="/sbin/shutdown -r now" \
    --selection-label
