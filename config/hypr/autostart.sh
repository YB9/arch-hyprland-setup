#!/bin/bash

# Wallpaper daemon
swww init &
swww img ~/.local/share/backgrounds/default.jpg &

# Bar and notifications
waybar &
mako &

# Clipboard manager
wl-paste --watch cliphist store &

# Optional: sleep delay for clean startup (esp. with multi-monitor)
sleep 1
