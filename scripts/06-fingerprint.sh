#!/bin/bash
set -e

echo "[6/7] 🔐 Setting up fingerprint authentication..."

# Install fingerprint tools
sudo pacman -S --noconfirm fprintd libfprint

# Enroll fingerprint (will prompt user)
echo "[*] Enrolling fingerprint now — follow the instructions:"
fprintd-enroll

# PAM configuration: add fingerprint auth to login and sudo

echo "[*] Updating PAM configs for fingerprint..."

PAM_FILES=(
  "/etc/pam.d/system-login"
  "/etc/pam.d/sudo"
)

for file in "${PAM_FILES[@]}"; do
  if ! grep -q "pam_fprintd.so" "$file"; then
    sudo sed -i '1iauth    sufficient    pam_fprintd.so' "$file"
    echo "  [✔] Updated $file"
  else
    echo "  [•] $file already configured"
  fi
done

echo "[6/7] ✅ Fingerprint login + sudo is now enabled."
