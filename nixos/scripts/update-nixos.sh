#!/usr/bin/env bash

# Change directory
echo "Changing directory to .dotfiles..."
cd /home/dom/.dotfiles/nixos

if [ $? -ne 0 ]; then
    echo "Error: Failed to change directory to .dotfiles/nixos. Does it exist?"
    exit 1
fi

# Update nixos
echo "Applying new NixOS configuration (sudo required)..."
sudo nixos-rebuild switch --flake

echo "Script finished."