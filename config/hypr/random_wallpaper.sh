#!/bin/bash

wall_dir="$HOME/Pictures/wallpapers"
random_wall=$(find "$wall_dir" -type f \( -iname '*.jpg' -o -iname '*.jpeg' -o -iname '*.png' -o -iname '*.gif' \) | shuf -n 1)

if [[ -n "$random_wall" ]]; then
  swww img "$random_wall" --transition-type grow --transition-fps 120 --transition-duration 1 --transition-pos 0,1080
fi
