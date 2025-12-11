#!/usr/bin/env bash

WALL_DIR="/home/$USER/Pictures/Wallpapers"

check_preq() {
  if [[ -z $(command -v swww) ]]; then
    notify-send "Cannot find 'swww' exiting..."
    exit 1
  fi

  if [[ -z $(pidof swww-daemon) ]]; then
    notify-send "'swww-daemon' is not running. Exiting..."
    exit 1
  fi

  if [[ -z $(command -v rofi) ]]; then
    notify-send "Cannot find 'rofi' exiting..."
    exit 1
  fi

  if [[ ! -d "$WALL_DIR" ]]; then
    notify-send "Cannot find wallpapers directory. Exiting..."
    exit 1
  fi
}

_swww() {
  swww img --transition-type center --transition-step 90 --transition-duration 2 --transition-fps 165 "$1"
}

walls() {
  WALLS=$(find "$WALL_DIR" -mindepth 1 -maxdepth 1 -type f -printf "%f\n")
  if [[ -z "$WALLS" ]]; then
    notify-send "Cannot find any wallpapers in wallpapers directory"
    exit 0
  else
    SELECTED=$(for a in $WALL_DIR/*; do
      echo -en "$a\0icon\x1f$a\n"
    done | rofi -dmenu -show-icons -theme wallpapers.rasi)

    if [[ -z "$SELECTED" ]]; then
      exit 0
    else
      SEL_WAL_ALONE=$(echo "$SELECTED" | sed "s|$WALL_DIR/||g")
      notify-send "Selected wallpaper: $SEL_WAL_ALONE"
      _swww "$SELECTED"
    fi
  fi
}

main() {
  check_preq
  walls
}

main
