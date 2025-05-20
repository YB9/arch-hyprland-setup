#!/bin/bash
set -e

echo "[5/7] ⚙️ Installing productivity tools, CLI enhancements, and terminal utilities..."

# Terminal CLI tools
sudo pacman -S --noconfirm \
  bat \
  fd \
  ripgrep \
  eza \
  btop \
  tmux \
  jq \
  fzf \
  htop \
  unzip \
  rsync \
  wget \
  curl \
  tree \
  neovim \
  zip

# Clipboard support (Wayland)
sudo pacman -S --noconfirm wl-clipboard cliphist

# Zsh and prompt tools
sudo pacman -S --noconfirm \
  starship \
  zsh-autosuggestions \
  zsh-syntax-highlighting

# Applications (Official repos)
sudo pacman -S --noconfirm \
  vlc \
  docker \
  docker-compose \
  gimp \
  audacity \
  qbittorrent \
  zathura \
  zathura-pdf-mupdf \
  libreoffice-fresh


# Applications (AUR)
yay -S --noconfirm \
  ungoogled-chromium-bin \
  spotify \
  visual-studio-code-bin \
  github-desktop-bin \
  timeshift-bin

# Setup .zshrc if not already configured
ZSHRC=~/.zshrc

if ! grep -q "starship" "$ZSHRC"; then
  echo 'eval "$(starship init zsh)"' >> "$ZSHRC"
fi

if ! grep -q "zsh-autosuggestions" "$ZSHRC"; then
  echo "source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh" >> "$ZSHRC"
fi

if ! grep -q "zsh-syntax-highlighting" "$ZSHRC"; then
  echo "source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> "$ZSHRC"
fi

# Setup bat alias
if ! grep -q "alias cat=" "$ZSHRC"; then
  echo "alias cat='bat'" >> "$ZSHRC"
fi

# Setup eza alias
if ! grep -q "alias ls=" "$ZSHRC"; then
  echo "alias ls='eza --icons'" >> "$ZSHRC"
fi

echo "[5/7] ✅ CLI tools, applications, and dev utilities installed."
