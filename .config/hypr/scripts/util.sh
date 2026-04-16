#!/usr/bin/env bash
case $1 in
  "lens")
      set -euo pipefail

      IMAGE="/tmp/lens.png"

      grim -g "$(slurp)" "$IMAGE"

      URL=$(curl -fsS -F "files[]=@$IMAGE" https://uguu.se/upload \
        | jq -r '.files[0].url')

      [[ -z "$URL" || "$URL" == "null" ]] && exit 1

      xdg-open "https://lens.google.com/uploadbyurl?url=$URL"

      # rm -f "$IMAGE"
      ;;

  "qr")
    REGION=$(slurp)

    RESULT=$(grim -g "$REGION" - | zbarimg -q --raw -)

    if [ -n "$RESULT" ]; then
        echo -n "$RESULT" | wl-copy
        notify-send "QR/Barcode Result" "Content copied to clipboard"
    else
        notify-send "QR/Barcode Result" "No code detected" -u low
    fi
    ;;

  "toggle-anim")
    HYPRANIM=$(hyprctl getoption animations:enabled | awk 'NR==1{print $2}')
    if [ "$HYPRANIM" = 1 ]; then
      hyprctl --batch "keyword animations:enabled 0;"
      notify-send "Animations are disabled!"
      exit 0
    else
      hyprctl --batch "keyword animations:enabled 1;"
      notify-send "Animations are enabled!"
      exit 0
    fi

    exit 1
    ;;

  "gamemode-on")
    hyprctl --batch "\
        keyword animations:enabled 0;\
        keyword animation borderangle,0; \
        keyword decoration:shadow:enabled 0;\
        keyword decoration:blur:enabled 0;\
      keyword decoration:fullscreen_opacity 1;\
        keyword general:gaps_in 0;\
        keyword general:gaps_out 0;\
        keyword general:border_size 1;\
        keyword decoration:rounding 0"
    powerprofilesctl set performance
    exit 0
    ;;

  "gamemode-off")
    hyprctl reload
    powerprofilesctl set balanced
    exit 0
    ;;

  *)
    echo "please provide an argument"
    ;;

esac
