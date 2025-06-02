#!/bin/bash

# Rofi teması
#ROFI_CMD="rofi -dmenu -p Power -theme ~/.config/rofi/power.rasi"
ROFI_CMD="rofi -dmenu -p Power"

# Menü seçenekleri
options="Power Off\nReboot\nSuspend\nLog Out"

chosen="$(echo -e "$options" | $ROFI_CMD)"

case "$chosen" in
    "Power Off")
        ~/.config/rofi/scripts/power.sh shutdown
        ;;
    "Reboot")
        ~/.config/rofi/scripts/power.sh reboot
        ;;
    "Suspend")
        ~/.config/rofi/scripts/power.sh suspend
        ;;
    "Log Out")
        ~/.config/rofi/scripts/power.sh exit
        ;;
esac
