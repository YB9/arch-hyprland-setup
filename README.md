# Arch Hyprland ThinkPad Setup

A modular, scriptable Arch Linux setup optimized for:

- 🧠 Tiling WM power: **Hyprland**
- 🔐 Fingerprint auth (ThinkPad T14s Gen 2 compatible)
- 🎯 Multi-monitor workflow (1 internal + 2 external)
- 🎨 Themed UI with Rofi, Waybar, wallpapers, GTK, and Zsh
- ⚡ Fast, minimal, keyboard-driven UX
- 🛠 Dev productivity out-of-the-box (Neovim, fzf, tmux, bat, ripgrep)

---

## 🔧 Installation

```bash
git clone https://github.com/YOUR_USERNAME/arch-hyprland-setup.git
cd arch-hyprland-setup
chmod +x install.sh
./install.sh
```

---

## 🧩 Structure

```
.
├── install.sh                # Master script to run all steps
├── scripts/                 # Layered setup scripts (01-07)
├── config/                  # WM, bar, launcher, shell configs
│   ├── hypr/
│   ├── waybar/
│   ├── rofi/
│   └── zsh/
├── wallpapers/              # Your wallpapers (default.jpg used)
└── README.md
```
