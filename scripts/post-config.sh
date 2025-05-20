#!/bin/bash
set -e

echo "🎯 Starting post-install config..."

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# ─────────────────────────────────────
# Config folders to overwrite
# ─────────────────────────────────────
echo "📁 Copying config files..."
CONFIGS=("hypr" "waybar" "rofi" "swaync" "zsh" "gtk-3.0" "gtk-4.0")

for cfg in "${CONFIGS[@]}"; do
  mkdir -p "$HOME/.config/$cfg"
  cp -r "$ROOT_DIR/config/$cfg/"* "$HOME/.config/$cfg/" 2>/dev/null || true
done

# ─────────────────────────────────────
# Wallpapers
# ─────────────────────────────────────
echo "🖼 Copying wallpapers..."
WALL_DIR="$HOME/Pictures/wallpapers"
mkdir -p "$WALL_DIR"
cp -r "$ROOT_DIR/wallpapers/"* "$WALL_DIR/" 2>/dev/null || true

# ─────────────────────────────────────
# Custom launchers
# ─────────────────────────────────────
echo "🚀 Copying .desktop launchers..."
mkdir -p "$HOME/.local/share/applications"
cp "$ROOT_DIR/launchers/"*.desktop "$HOME/.local/share/applications/" 2>/dev/null || true

# ─────────────────────────────────────
# Zsh: Add QT theme env variable
# ─────────────────────────────────────
if ! grep -q "QT_QPA_PLATFORMTHEME=qt5ct" "$HOME/.zshrc" 2>/dev/null; then
  echo "export QT_QPA_PLATFORMTHEME=qt5ct" >> "$HOME/.zshrc"
  echo "🔧 Added QT_QPA_PLATFORMTHEME to .zshrc"
fi

# ─────────────────────────────────────
# Optional: Fingerprint setup
# ─────────────────────────────────────
echo ""
echo "🔐 Fingerprint setup..."
read -p "Would you like to set up fingerprint login now? [y/N]: " answer
answer=${answer,,}

if [[ "$answer" =~ ^(y|yes)$ ]]; then
  if ! command -v fprintd-enroll &>/dev/null; then
    echo "⚠️  fprintd not found. Please install it first."
  else
    echo "[*] Attempting fingerprint enrollment..."
    if systemd-run --user --wait fprintd-enroll; then
      echo "🔐 Updating PAM configs..."
      PAM_FILES=(
        "/etc/pam.d/system-login"
        "/etc/pam.d/sudo"
      )
      for file in "${PAM_FILES[@]}"; do
        if ! grep -q "pam_fprintd.so" "$file"; then
          sudo sed -i '1iauth    sufficient    pam_fprintd.so' "$file"
          echo "  ✔ Added fingerprint auth to $file"
        else
          echo "  • $file already configured"
        fi
      done
      echo "✅ Fingerprint login configured."
    else
      echo "❌ Failed to enroll fingerprint. Make sure you are in a Wayland/X11 session and not running this from a TTY."
    fi
  fi
else
  echo "⏭️  Skipping fingerprint setup."
fi

# ─────────────────────────────────────
# Done — Reboot to apply everything
# ─────────────────────────────────────
echo "✅ Post-install config complete. Rebooting..."
sleep 3
reboot
