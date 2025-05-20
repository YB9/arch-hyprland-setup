#!/bin/bash

wall_dir="$HOME/Pictures/wallpapers"
random_wall=$(find "$wall_dir" -type f \( -iname '*.jpg' -o -iname '*.jpeg' -o -iname '*.png' -o -iname '*.gif' \) | shuf -n 1)

if [ -n "$random_wall" ]; then
  # Set the wallpaper
  swww img "$random_wall" \
  --transition-type grow \
  --transition-fps 120 \
  --transition-duration 1.0 \
  --transition-pos 0,1080


  # Extract brightness (0–255)
  brightness=$(convert "$random_wall" -resize 1x1 -format "%[fx:mean*255]" info:)

  # Determine text color
  if (( $(echo "$brightness > 128" | bc -l) )); then
    text_color="#000000"  # black
  else
    text_color="#ffffff"  # white
  fi

  # Replace any existing "color: ..." line in style.css
  sed -i "s/^.*color: *#[0-9a-fA-F]\{6\};/  color: $text_color;/" ~/.config/waybar/style.css

  # Reload waybar
  pkill waybar && waybar &
fi
