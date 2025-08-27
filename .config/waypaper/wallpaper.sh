#!/bin/bash

sleep 1

WALLPAPER=$(swww query | sed -n 's/.*image: \(.*\)$/\1/p')

wal -i $WALLPAPER -e -n -s -t
matugen image $WALLPAPER
ln -sf ~/.cache/wal/colors-kitty.conf ~/.config/kitty/16-colors.conf
ln -sf ~/.cache/wal/colors-foot.ini ~/.config/foot/16-colors.ini
sed -i 's/#//g' ~/.config/foot/16-colors.ini
~/.config/matugen/papirus-folders/change-icons.sh
