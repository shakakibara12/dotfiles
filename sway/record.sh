#!/usr/bin/env  bash


#install `wf-recorder` to use this script
#       https://github.com/ammen99/wf-recorder

#check if running wayland

if [[ "$XDG_SESSION_TYPE" != wayland ]]; then
    echo "You are not running wayland!!" && exit
fi
#list audio outputs with this
# ` pactl list sinks | awk '/Name:/ {print $2}' | awk 'NR==1' `
device=$(pactl get-default-sink)
name="$HOME/Videos/$(date +'%Y-%m-%d_%I-%M-%S').mkv"
codec_param="-p "crf=20" -p "fpsmax=30" "
mic_default=$(pactl get-default-source)
monitor="alsa_output.usb-C-Media_Electronics_Inc._USB_Audio_Device-00.analog-stereo.monitor"

#quick fix for audio capture
#set default source to monitor to capture desktop audio
pactl set-default-source $monitor

function show_help () {
    printf "%s\n" "Usage:"
    printf "%s\n" "-g | --geometry , record selected geometry"
    printf "%s\n" "-s | --screen, record fullscreen"
    printf "%s\n" "-h | --help, shows help"
}

#checks if wf-recorder is running
pgrep -x "wf-recorder" > /dev/null && killall -s SIGINT wf-recorder && notify-send "Recording stopped" && exit

#if [[ "$1" == "-g" ]] || [[ "$1" == "--geometry" ]]; then
#    wf-recorder -g "$(slurp)" -f $name --codec libx264rgb --device /dev/dri/renderD128 $codec_param --audio $device --force-yuv 
#elif [[ "$1" == "-s" ]] || [[ "$1" == "--screen" ]]; then
#    wf-recorder -f $name --codec libx264rgb --device /dev/dri/renderD128 $codec_param --audio $device --force-yuv 
#elif [[ "$1" == "-h" ]] || [[ "$1" == "--help" ]]; then
#    show_help
#else
#    exit
#fi
case "$1" in
    -h|--help )
      show_help
      ;;
    -s|--screen )
      shift
      notify-send "Recording started"
      wf-recorder -f $name --codec libx264rgb --device /dev/dri/renderD128 $codec_param --audio $device --force-yuv
      ;;
    -g|--geometry )
      shift
      notify-send "Recording started"
      wf-recorder -g "$(slurp)" -f $name --codec libx264rgb --device /dev/dri/renderD128 $codec_param --audio $device --force-yuv
      ;;
    *)
   echo "Incorrect input provided"
   show_help
esac

#revert source to default device after recording is done
pactl set-default-source $mic_default

exit
