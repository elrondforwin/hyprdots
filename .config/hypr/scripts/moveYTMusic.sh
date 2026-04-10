#!/bin/bash

_APP_CLASS="com.github.th_ch.youtube_music"

if hyprctl clients -j | jq -e '.[] | select(.class=="com.github.th_ch.youtube_music") | .floating' | grep -q true; then
    echo "current state: floating"
else
    echo "current state: tiled, changing to floating"
    hyprctl dispatch togglefloating class:$_APP_CLASS
fi
hyprctl dispatch resizewindowpixel exact 1000 1028,class:$_APP_CLASS
hyprctl dispatch movewindowpixel exact 10 40,class:$_APP_CLASS
