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
  git clone https://github.com/l3ngenDairy/da-desktop "${HOME}/da-desktop"
  cd "${HOME}/da-desktop"
else
  cd "${HOME}/da-desktop"
fi

echo '==> Adding hardware-configuration'
# Create a temporary directory
TMP_DIR=$(mktemp -d)
echo "==> Created temporary directory: $TMP_DIR"

# Generate hardware configuration to the temporary directory
sudo nixos-generate-config --dir "$TMP_DIR"
echo "==> Generated hardware configuration"

# Check if the file was generated
if [ -f "$TMP_DIR/hardware-configuration.nix" ]; then
  echo "==> Hardware configuration file generated successfully"

  # Force-remove existing file if it exists
  if [ -f "${HOME}/da-desktop/hardware-configuration.nix" ]; then
    echo "==> Removing existing hardware configuration file"
    sudo rm "${HOME}/da-desktop/hardware-configuration.nix"
  fi

  # Copy with verbose flag to see what's happening
  echo "==> Copying new hardware configuration file"
  sudo cp -v "$TMP_DIR/hardware-configuration.nix" "${HOME}/da-desktop/"

  # Verify the copy operation
  if [ -f "${HOME}/da-desktop/hardware-configuration.nix" ]; then
    echo "==> Hardware configuration copied successfully"
    echo "==> Content of hardware-configuration.nix:"
    head -n 3 "${HOME}/da-desktop/hardware-configuration.nix"
  else
    echo "==> ERROR: Failed to copy hardware configuration"
    exit 1
  fi
else
  echo "==> ERROR: Failed to generate hardware configuration"
  exit 1
fi

# Clean up
echo "==> Cleaning up temporary directory"
sudo rm -rf "$TMP_DIR"

# Install default configuration
echo "==> Installing system configuration..."
sudo nixos-rebuild switch --flake ".#da-desktop" --impure

echo "==> da-desktop setup complete!"
