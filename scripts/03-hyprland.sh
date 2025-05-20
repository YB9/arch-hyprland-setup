#!/bin/bash
set -e

echo "[3/7] 🎛 Installing Hyprland, essential Wayland tools, and setting up autostart..."

# Install Hyprland and core Wayland desktop packages
sudo pacman -S --noconfirm \
  hyprland \
  waybar \
  rofi \
  swww \
  mako \
  xdg-desktop-portal-hyprland \
  xdg-utils \
  xdg-user-dirs \
  wl-clipboard \
  qt5-wayland \
  qt6-wayland \
  polkit-kde-agent \
  thunar \
  alacritty

# Create base config folders
mkdir -p ~/.config/hypr
mkdir -p ~/.config/waybar
mkdir -p ~/.config/rofi
mkdir -p ~/.config/mako
mkdir -p ~/.config/zsh
mkdir -p ~/.local/share/backgrounds

# Copy example configs (to be overridden later with your dotfiles if you like)
cp -r config/hypr/* ~/.config/hypr/ 2>/dev/null || true
cp -r config/waybar/* ~/.config/waybar/ 2>/dev/null || true
cp -r config/rofi/* ~/.config/rofi/ 2>/dev/null || true
cp -r wallpapers/* ~/.local/share/backgrounds/ 2>/dev/null || true

# Set up user-dirs (Downloads, Documents, etc.)
xdg-user-dirs-update

# Autostart script
cat > ~/.config/hypr/autostart.sh << 'EOF'
#!/bin/bash
swww init &
swww img ~/.local/share/backgrounds/default.jpg &
waybar &
mako &
EOF

chmod +x ~/.config/hypr/autostart.sh

# Hook autostart into Hyprland
if ! grep -q "exec-once" ~/.config/hypr/hyprland.conf 2>/dev/null; then
  echo "exec-once = ~/.config/hypr/autostart.sh" >> ~/.config/hypr/hyprland.conf
fi

echo "[3/7] ✅ Hyprland and Wayland environment installed."
