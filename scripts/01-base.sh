#!/bin/bash
set -e

echo "[1/7] 🧱 Installing base packages and enabling core services..."

# Update package list
sudo pacman -Syu --noconfirm

# Install essential base packages
sudo pacman -S --noconfirm \
  git \
  base-devel \
  zsh \
  neovim \
  wget \
  curl \
  unzip \
  nano \
  sudo \
  man-db \
  reflector \
  networkmanager \
  dialog \
  lsb-release \
  openssh \
  rsync \
  gnupg \
  pacman-contrib

# Set fastest mirrors
sudo reflector --latest 10 --sort rate --save /etc/pacman.d/mirrorlist

# Enable key services
sudo systemctl enable NetworkManager
sudo systemctl enable sshd

# Set zsh as default shell
chsh -s /bin/zsh "$USER"

echo "[1/7] ✅ Base system setup complete."
