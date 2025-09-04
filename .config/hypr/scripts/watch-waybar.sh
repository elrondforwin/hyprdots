#!/bin/bash

waybar_visible=false

monitor=$(hyprctl monitors -j | jq -r '.[0].name')

while true; do
  active_workspace=$(hyprctl activeworkspace -j | jq -r '.id')
  window_count=$(hyprctl clients -j | jq "[.[] | select(.workspace.id == $active_workspace and .mapped == true)] | length")

  if [ "$window_count" -eq 0 ]; then

    if $waybar_visible; then
      pkill -x waybar
      waybar_visible=false
    fi

  else
    if ! $waybar_visible; then
      nohup waybar >/dev/null 2>&1 &
      waybar_visible=true
    fi

  fi

  sleep 0.2

done
