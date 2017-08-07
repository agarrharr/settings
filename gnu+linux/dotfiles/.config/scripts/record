#!/bin/bash
# Reference: https://ro-che.info/articles/2017-07-21-record-audio-linux

function record_mic() {
  path="${HOME}/Documents/recording"
  filename=$(get_filename $path "mic")
  echo "Recording mic at ${path}/${filename}"
  parecord --channels=1 -d alsa_input.usb-Blue_Microphones_Yeti_Stereo_Microphone_REV8-00.analog-stereo $path/$filename &
}

function record_skype() {
  path="${HOME}/Documents/recording"
  filename=$(get_filename $path "skype")
  echo "Recording skype at ${path}/${filename}"
  parecord --channels=1 -d recording.monitor $path/$filename &
}

function get_filename() {
  path=$1
  name=$2
  if [[ -e $path/$name.wav ]] ; then
    i=2
    while [[ -e "${path}/${name}-${i}.wav" ]] ; do
      let i++
    done
    name=$name-$i
  fi
  echo $name.wav
}

record_mic
record_skype
