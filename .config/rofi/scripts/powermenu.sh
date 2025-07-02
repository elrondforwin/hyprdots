#!/bin/bash

# Rofi teması
ROFI_CMD="rofi -dmenu -p Power -theme ~/.config/rofi/powermenu/powermenu.rasi"

shutdown='󰐥'
reboot='󰑓'
lock=''
suspend=''
logout=''
yes=''
no=''

# Menü seçenekleri
options="$shutdown\n$reboot\n$suspend\n$logout"

chosen="$(echo -e "$options" | $ROFI_CMD)"

case "$chosen" in
    "$shutdown")
        ~/.config/rofi/scripts/power.sh shutdown
        ;;
    "$reboot")
        ~/.config/rofi/scripts/power.sh reboot
        ;;
    "$suspend")
        ~/.config/rofi/scripts/power.sh suspend
        ;;
    "$logout")
        ~/.config/rofi/scripts/power.sh exit
        ;;

esac
