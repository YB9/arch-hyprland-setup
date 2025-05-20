#!/bin/bash
set -e

echo "[4/7] 🎨 Installing fonts, icons, and GTK theming tools..."

# Install fonts and icon packs
sudo pacman -S --noconfirm \
  ttf-jetbrains-mono \
  ttf-fira-code \
  ttf-nerd-fonts-symbols \
  ttf-font-awesome \
  papirus-icon-theme \
  materia-gtk-theme \
  lxappearance

# Set a wallpaper as default
WALLPAPER=~/.local/share/backgrounds/default.jpg

if [[ ! -f "$WALLPAPER" ]]; then
  echo "[!] No default wallpaper found, downloading placeholder..."
  mkdir -p ~/.local/share/backgrounds
  curl -L -o "$WALLPAPER" https://picsum.photos/1920/1080
fi

# Create GTK theme configuration
mkdir -p ~/.config/gtk-3.0/
cat > ~/.config/gtk-3.0/settings.ini <<EOF
[Settings]
gtk-theme-name=Materia-dark
gtk-icon-theme-name=Papirus-Dark
gtk-font-name=JetBrains Mono 10
EOF

# Configure Qt environment variables for theming
echo "export QT_QPA_PLATFORMTHEME=qt5ct" >> ~/.zshrc

# Set environment variables in Hyprland (if not already set)
if ! grep -q "QT_QPA_PLATFORMTHEME" ~/.config/hypr/hyprland.conf 2>/dev/null; then
  echo "env = QT_QPA_PLATFORMTHEME,qt5ct" >> ~/.config/hypr/hyprland.conf
fi

echo "[4/7] ✅ Theming applied: fonts, icons, GTK, Qt, wallpaper."
