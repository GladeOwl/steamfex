#!/bin/bash
set -e

ROOTFS_PATH="/home/fex/.fex-emu/RootFS/"
STEAM_PATH="/home/steam/steam"

if [ ! -d "$ROOTFS_PATH" ] || [ -z "$(ls -A "$ROOTFS_PATH")" ]; then
    echo "==> RootFS not found. Running FEXRootFSFetcher..."
    expect /tmp/expect.exp
else
    echo "==> RootFS already installed. Skipping..."
fi

if [ ! -d "$STEAM_PATH" ] || [ -z "$(ls -A "$STEAM_PATH")" ]; then
    echo "==> Installing Steam and Valheim..."
    FEXBash "/home/steam/Steam/steamcmd.sh"
else
    echo "==> Steam install script not found. Assuming installed. Skipping..."
fi

exec "$@"