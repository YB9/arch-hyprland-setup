#!/bin/bash
set -e

echo "[7/7] 🧹 Finalizing setup and prepping system for first Hyprland launch..."

# Make sure all scripts are executable (failsafe)
chmod +x ~/arch-hyprland-setup/scripts/*.sh 2>/dev/null || true

# Set permissions for config files (failsafe)
chmod -R 755 ~/.config 2>/dev/null || true

# Update system one last time
echo "[*] Doing a final package update check..."
sudo pacman -Syu --noconfirm

# Show user a summary
echo ""
echo "🎉 All setup scripts complete!"
echo ""
echo "👉 Next Steps:"
echo "- Reboot your system"
echo "- Login via TTY or display manager"
echo "- Run: Hyprland"
echo ""
echo "🧠 Reminder:"
echo "- Your fingerprint works for login and sudo"
echo "- Default wallpaper and themes are applied"
echo "- Use lxappearance to tweak GTK if needed"
echo ""
echo "✅ System is ready to use Hyprland productively!"
