#!/bin/sh

#list outputs with this command
# pactl list sinks | grep "Name:" | cut -d ":" -f 2

cmd=$(pactl get-default-sink)
device1=alsa_output.usb-C-Media_Electronics_Inc._USB_Audio_Device-00.analog-stereo
device2=alsa_output.pci-0000_00_03.0.hdmi-stereo

[[ $cmd == $device1 ]] \
&& echo "changing to speaker" $(pactl set-default-sink $device2) \
|| echo "changing to headphone" $(pactl set-default-sink $device1)
