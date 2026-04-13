#!/bin/bash

case "$1" in
  enable)
    hyprctl output create headless IPAD
    ;;
  disable)
    hyprctl output remove IPAD
    ;;
  *)
    echo "USAGE: virtscreen [enable|disable]"
    ;;
esac
