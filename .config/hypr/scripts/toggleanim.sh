#!/usr/bin/env bash

HYPRANIM=$(hyprctl getoption animations:enabled | awk 'NR==1{print $2}')
if [ "$HYPRANIM" = 1 ]; then
  hyprctl --batch "keyword animations:enabled 0;"
  notify-send "Animations are disabled!"
  exit 0
else
  hyprctl --batch "keyword animations:enabled 1;"
  notify-send "Animations are enabled!"
  exit 0
fi

exit 1
