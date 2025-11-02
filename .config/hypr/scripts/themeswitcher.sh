#!/usr/bin/env bash

THEME_DIR="/home/$USER/.themes"
CONFIG_DIR="/home/$USER/.config"

check_theme_dir() {
  if [[ ! -d "$THEME_DIR" ]]; then
    echo "Creating theme directory"
    mkdir -p "$THEME_DIR"
  fi
}

query() {
  find "$1" -mindepth 1 -maxdepth 1 -type d -printf "%f\n"
}

apply_theme() {

  if [[ -f "$THEME_DIR/$SELECTED/apply.sh" ]]; then
    bash "$THEME_DIR/$SELECTED/apply.sh"
  fi

}

list_themes() {
  if [[ -z "$(query $THEME_DIR)" ]]; then
    notify-send "Your theme folder is empty. Please create some themes in $THEME_DIR directory."
    exit 1
  fi

  SELECTED=$(query "$THEME_DIR" | rofi -dmenu)

  apply_theme
}

main() {
  check_theme_dir
  list_themes
}

main

