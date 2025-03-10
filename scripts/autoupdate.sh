#!/usr/bin/env bash
set -euo pipefail

# Function to detect hostname
detect_hostname() {
  hostname=$(hostname)
  if [[ -z "$hostname" ]]; then
    echo "Error: Unable to detect hostname. Exiting..."
    exit 1
  fi
  echo "==> Detected hostname: ${hostname}"
}

# Function to update da-desktop
update_da-desktop() {
  echo "==> Updating da-desktop..."
  cd "${HOME}/da-desktop"

  # Check for local changes
  if [[ -n "$(git status --porcelain)" ]]; then
    echo "==> Local changes detected. Stashing..."
    git stash
  fi

  # Pull latest changes
  echo "==> Pulling latest changes..."
  git pull origin main
}

# Function to rebuild the system
rebuild_system() {
  local hostname=$1
  echo "==> Rebuilding system for hostname: ${hostname}..."
  sudo nixos-rebuild switch --flake ~/da-desktop/.#"$hostname"
}

# Main function
main() {
  detect_hostname
  update_da-desktop
  rebuild_system "$hostname"
  echo "==> Update complete!"
}

main
