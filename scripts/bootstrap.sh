#!/usr/bin/env bash
set -euo pipefail

# Bootstrap script for new machine setup

echo "==> Setting up da-desktop..."

# Ensure nix is installed
if ! command -v nix >/dev/null 2>&1; then
  echo "==> Installing Nix..."
  sh <(curl -L https://nixos.org/nix/install) --daemon
fi

# Ensure flakes are enabled
if ! grep -q "experimental-features" ~/.config/nix/nix.conf 2>/dev/null; then
  mkdir -p ~/.config/nix
  echo "experimental-features = nix-command flakes" >> ~/.config/nix/nix.conf
fi

# Clone the repository if running from a downloaded script
if [[ ! -d "${HOME}/da-desktop" ]]; then
  echo "==> Cloning da-desktop repository..."
  git clone https://github.com/l3ngenDairy/da-desktop  "${HOME}/da-desktop"
  cd "${HOME}/da-desktop"
else
  cd  "${HOME}/da-desktop"
fi
echo '==> Adding hardware-configuration'
sudo nixos-generate-config --root /
sudo cp /etc/nixos/hardware-configuration.nix "${HOME}/da-desktop"

# Detect hostname for configuration
#HOST=$(hostname)
#echo "==> Detected hostname: ${HOST}"

# Install the configuration
#echo "==> Installing system configuration..."
#sudo nixos-rebuild switch --flake ".#${HOST}" --impure


# Install default configuration
echo "==> Installing system configuration..."
sudo nixos-rebuild switch --flake ".#da-desktop" --impure

echo "==> da-desktop setup complete!"
