#!/bin/sh
name="$1"
shift
PATHS="org.mpris.MediaPlayer2.$name /org/mpris/MediaPlayer2"
DBUS_SEND="dbus-send --type=method_call --dest=$PATHS"
RC="$DBUS_SEND org.mpris.MediaPlayer2.Player"
if [ "$@" = "prev" ]; then
    $RC.Previous
elif [ "$@" = "stop" ]; then
    $RC.Pause
elif [ "$@" = "toggle" ]; then
    $RC.PlayPause
elif [ "$@" = "next" ]; then
    $RC.Next
elif [ "$@" = "back5" ]; then
    $RC.Seek int64:-5000000
elif [ "$@" = "speed100" ]; then
    dbus-send --print-reply --session --dest=org.mpris.MediaPlayer2.vlc /org/mpris/MediaPlayer2 org.freedesktop.DBus.Properties.Set string:org.mpris.MediaPlayer2.Player string:Rate variant:double:"1.0"
elif [ "$@" = "speed125" ]; then
    dbus-send --print-reply --session --dest=org.mpris.MediaPlayer2.vlc /org/mpris/MediaPlayer2 org.freedesktop.DBus.Properties.Set string:org.mpris.MediaPlayer2.Player string:Rate variant:double:"1.25"
elif [ "$@" = "speed150" ]; then
    dbus-send --print-reply --session --dest=org.mpris.MediaPlayer2.vlc /org/mpris/MediaPlayer2 org.freedesktop.DBus.Properties.Set string:org.mpris.MediaPlayer2.Player string:Rate variant:double:"1.5"
elif [ "$@" = "speed200" ]; then
    dbus-send --print-reply --session --dest=org.mpris.MediaPlayer2.vlc /org/mpris/MediaPlayer2 org.freedesktop.DBus.Properties.Set string:org.mpris.MediaPlayer2.Player string:Rate variant:double:"2.0"
method return time=1502119199.486059 sender=:1.259 -> destination=:1.394 serial=245 reply_serial=2
elif [ "$@" = "random" ]; then
    current=$(mdbus2 $PATHS org.freedesktop.DBus.Properties.Get org.mpris.MediaPlayer2.Player Shuffle)
    if [ "$current" = "( true)" ]; then
        other=false
    else
        other=true
    fi
    $DBUS_SEND org.freedesktop.DBus.Properties.Set string:org.mpris.MediaPlayer2.Player string:Shuffle variant:boolean:$other
else
    echo "Command not found for player $name: $@" 1>&2
    exit 1
fi
