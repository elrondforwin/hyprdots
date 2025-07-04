#!/bin/bash

sleep 1

WALLPAPER=$(swww query | sed -n 's/.*image: \(.*\)$/\1/p')

matugen image $WALLPAPER
wallust run $WALLPAPER
~/.config/matugen/papirus-folders/change-icons.sh