#!/usr/bin/env bash

CUR_THEME_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
THEME="$(echo "${CUR_THEME_DIR##*/}")"
THEMES_DIR="/home/$USER/.themes"
ACTIVE_DIR="$THEMES_DIR/$THEME"
CONFIG_DIR="/home/$USER/.config"

# qt colors
ln -sf "$ACTIVE_DIR/qt.colors" "/home/$USER/.local/share/color-schemes/active.colors"
# gtk colors
ln -sf "$ACTIVE_DIR/gtk-3.0" "$CONFIG_DIR"
ln -sf "$ACTIVE_DIR/gtk-4.0" "$CONFIG_DIR"
# kitty colors
ln -sf "$ACTIVE_DIR/kitty/16-colors.conf" "$CONFIG_DIR/kitty/16-colors.conf"
ln -sf "$ACTIVE_DIR/kitty/bg-colors.conf" "$CONFIG_DIR/kitty/bg-colors.conf"
ln -sf "$ACTIVE_DIR/kitty/tabs-colors.conf" "$CONFIG_DIR/kitty/tabs-colors.conf"
# foot colors
ln -sf "$ACTIVE_DIR/foot/foot-colors.ini" "$CONFIG_DIR/foot/foot-colors.ini"
ln -sf "$ACTIVE_DIR/foot/16-colors.ini" "$CONFIG_DIR/foot/16-colors.ini"
# reload kitty
pkill -SIGUSR1 kitty
# discord colors # not supported in this theme, I'm not using vesktop anymore #
# ln -sf "$ACTIVE_DIR/discord.css" "$CONFIG_DIR/vesktop/themes/active.css"
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
# neovim theme
ln -sf "$ACTIVE_DIR/set_theme.lua" "$CONFIG_DIR/nvim/lua/plugins/set_theme.lua"

# apply wallpaper
# swww img "$ACTIVE_DIR/wallpaper.png"

# notify user
notify-send "$THEME applied."
