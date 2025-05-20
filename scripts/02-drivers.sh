#!/bin/bash
set -e

echo "[2/7] 🔧 Installing drivers and firmware..."

# Install CPU microcode (Intel for ThinkPad)
sudo pacman -S --noconfirm intel-ucode

# Install GPU and graphics-related packages
sudo pacman -S --noconfirm \
  mesa \
  vulkan-intel \
  libva-intel-driver \
  libvdpau-va-gl \
  xf86-video-intel # Optional: good fallback for X, not required on Wayland

# Install audio stack (PipeWire)
sudo pacman -S --noconfirm \
  pipewire \
  pipewire-audio \
  pipewire-alsa \
  pipewire-jack \
  pipewire-pulse \
  wireplumber

# Enable audio
systemctl --user enable pipewire pipewire-pulse wireplumber || true

# Bluetooth support
sudo pacman -S --noconfirm bluez bluez-utils blueman
sudo systemctl enable bluetooth.service

# Battery & power management for laptops
sudo pacman -S --noconfirm tlp
sudo systemctl enable tlp

# File system tools
sudo pacman -S --noconfirm btrfs-progs dosfstools exfatprogs ntfs-3g

echo "[2/7] ✅ Drivers and firmware installed."
