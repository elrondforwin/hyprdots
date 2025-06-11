#!/bin/bash
selected=$(fd --hidden --no-ignore . ~ | rofi -dmenu -i -p "Search" -theme-str 'window { width: 600px; }')
[[ -n "$selected" ]] && xdg-open "$selected"