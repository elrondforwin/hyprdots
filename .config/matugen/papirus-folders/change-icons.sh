#!/usr/bin/env bash

# Catppuccin Mocha renk paleti (renk ismi → hex kodu)
declare -A colors=(
  [cat-mocha-blue]="#89B4FA"
  [cat-mocha-flamingo]="#F2CDCD"
  [cat-mocha-green]="#A6E3A1"
  [cat-mocha-lavender]="#B4BEFE"
  [cat-mocha-maroon]="#EBA0AC"
  [cat-mocha-mauve]="#CBA6F7"
  [cat-mocha-peach]="#FAB387"
  [cat-mocha-pink]="#F5C2E7"
  [cat-mocha-red]="#F38BA8"
  [cat-mocha-rosewater]="#F5E0DC"
  [cat-mocha-sapphire]="#74C7EC"
  [cat-mocha-sky]="#89DCEB"
  [cat-mocha-teal]="#94E2D5"
  [cat-mocha-yellow]="#F9E2AF"
)

# Hex kodunu plaintext dosyadan oku
hex=$(<~/.config/matugen/papirus-folders/folder-color.txt)

# HEX'i RGB'ye çeviren fonksiyon
hex_to_rgb() {
  local hex=$1
  local r=$((16#${hex:1:2}))
  local g=$((16#${hex:3:2}))
  local b=$((16#${hex:5:2}))
  echo "$r $g $b"
}

read r1 g1 b1 <<< "$(hex_to_rgb "$hex")"

# En yakın rengi bul
min_distance=1000000
closest_color=""

for name in "${!colors[@]}"; do
  read r2 g2 b2 <<< "$(hex_to_rgb "${colors[$name]}")"
  distance=$(( (r1 - r2) * (r1 - r2) + (g1 - g2) * (g1 - g2) + (b1 - b2) * (b1 - b2) ))
  if (( distance < min_distance )); then
    min_distance=$distance
    closest_color=$name
  fi
done

echo "Closest Catppuccin Mocha color to $hex is: $closest_color"
~/.local/share/icons/papirus-folders.sh -C $closest_color -t ~/.local/share/icons/Papirus-Dark