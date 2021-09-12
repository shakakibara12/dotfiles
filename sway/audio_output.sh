#!/bin/sh

#list outputs with this command
# pactl list sinks | awk '/Name:/ {print $2}'

cmd=$(pactl get-default-sink)
device1=$(pactl list sinks | awk '/Name:/ {print $2}' | awk 'NR==1')
device2=$(pactl list sinks | awk '/Name:/ {print $2}' | awk 'NR==2')

[[ $cmd == $device1 ]] \
&& echo "changing to speaker" $(pactl set-default-sink $device2) \
|| echo "changing to headphone" $(pactl set-default-sink $device1)
exit
