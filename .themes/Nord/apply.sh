#!/usr/bin/env bash

THEME="Nord"
THEMES_DIR="/home/$USER/.themes"
ACTIVE_DIR="$THEMES_DIR/$THEME"
CONFIG_DIR="/home/$USER/.config"

# qt colors
ln -sf "$ACTIVE_DIR/qt.colors" "/home/$USER/.local/share/color-schemes/active.colors"
# gtk colors
ln -sf "$ACTIVE_DIR/gtk-3.0" "$CONFIG_DIR"
ln -sf "$ACTIVE_DIR/gtk-4.0" "$CONFIG_DIR"
# foot terminal colors
ln -sf "$ACTIVE_DIR/foot/16-colors.ini" "$CONFIG_DIR/foot/16-colors.ini"
ln -sf "$ACTIVE_DIR/foot/foot-colors.ini" "$CONFIG_DIR/foot/foot-colors.ini"
# discord colors
ln -sf "$ACTIVE_DIR/discord.css" "$CONFIG_DIR/vesktop/themes/active.css"
# hypr colors
ln -sf "$ACTIVE_DIR/colors.conf" "$CONFIG_DIR/hypr/colors.conf"
# rofi colors
ln -sf "$ACTIVE_DIR/colors.rasi" "$CONFIG_DIR/rofi/colors.rasi"
# yazi colors
ln -sf "$ACTIVE_DIR/theme.toml" "$CONFIG_DIR/yazi/"
# dunst colors
ln -sf "$ACTIVE_DIR/dunstrc" "$CONFIG_DIR/dunst/dunstrc"
pkill dunst
# waybar colors
ln -sf "$ACTIVE_DIR/colors.css" "$CONFIG_DIR/waybar/colors.css"
pkill waybar && waybar &
disown

# apply wallpaper
swww img "$ACTIVE_DIR/wallpaper.png"

# notify user
notify-send "$THEME applied."

