#!/bin/bash
set -e

echo "🚀 Starting base system install for Hyprland..."

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PKG_DIR="$ROOT_DIR/packages"

# ─────────────────────────────────────
# Ensure yay is installed
# ─────────────────────────────────────
if ! command -v yay &>/dev/null; then
  echo "📦 Installing yay (AUR helper)..."
  sudo pacman -S --needed --noconfirm git base-devel
  git clone https://aur.archlinux.org/yay.git "$HOME/yay-tmp"
  cd "$HOME/yay-tmp"
  makepkg -si --noconfirm
  cd "$ROOT_DIR"
  rm -rf "$HOME/yay-tmp"
fi

# ─────────────────────────────────────
# Update mirrorlist
# ─────────────────────────────────────
echo "🌐 Updating fastest mirrors..."
sudo reflector --latest 10 --sort rate --save /etc/pacman.d/mirrorlist

# ─────────────────────────────────────
# Install all pacman packages
# ─────────────────────────────────────
echo "📦 Installing all pacman packages from pacman.txt..."
grep -vE '^\s*#|^\s*$' "$PKG_DIR/pacman.txt" | xargs -r sudo pacman -S --noconfirm --needed

# ─────────────────────────────────────
# Install AUR apps from yay.txt
# ─────────────────────────────────────
echo "📦 Installing AUR apps from yay.txt..."
grep -vE '^\s*#|^\s*$' "$PKG_DIR/yay.txt" | xargs -r yay -S --noconfirm --needed

# ─────────────────────────────────────
# Enable services
# ─────────────────────────────────────
echo "🔧 Enabling system services..."
sudo systemctl enable NetworkManager
sudo systemctl enable bluetooth
sudo systemctl enable sshd
sudo systemctl enable tlp
sudo systemctl enable sddm

echo "🔧 Enabling user services..."
systemctl --user enable pipewire
systemctl --user enable pipewire-pulse
systemctl --user enable wireplumber

# ─────────────────────────────────────
# Set Zsh as default shell
# ─────────────────────────────────────
if [[ "$SHELL" != "/bin/zsh" ]]; then
  echo "🐚 Setting Zsh as your default shell..."
  chsh -s /bin/zsh "$USER"
fi

# ─────────────────────────────────────
# Done — Reboot into GUI
# ─────────────────────────────────────
echo "✅ Base install complete. Rebooting..."
sleep 3
sudo reboot
