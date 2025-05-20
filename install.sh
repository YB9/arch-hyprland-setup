#!/bin/bash

# === install.sh ===
# Master script to automate Arch + Hyprland setup for ThinkPad

set -e

SCRIPTS=(
  "scripts/01-base.sh"
  "scripts/02-drivers.sh"
  "scripts/03-hyprland.sh"
  "scripts/04-theming.sh"
  "scripts/05-utilities.sh"
  "scripts/06-fingerprint.sh"
  "scripts/07-finalize.sh"
)

for script in "${SCRIPTS[@]}"; do
  echo "[+] Running $script"
  bash "$script"
  echo
done

echo "[+] Setup complete. Reboot recommended."
