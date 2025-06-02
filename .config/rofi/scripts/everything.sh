#!/bin/bash
selected=$(fd --hidden --no-ignore . ~ | rofi -dmenu -i -p "Search")
[[ -n "$selected" ]] && xdg-open "$selected"