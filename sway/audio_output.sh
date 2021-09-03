#!/bin/sh

#set speaker default
pactl set-default-sink alsa_output.pci-0000_00_03.0.hdmi-stereo
#set headphone default
pactl set-default-sink alsa_output.usb-C-Media_Electronics_Inc._USB_Audio_Device-00.analog-stereo
