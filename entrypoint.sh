#!/bin/bash
set -e


FIRST_TIME_FLAG="/tmp/first_time_flag"

if [ ! -f "$FIRST_TIME_FLAG" ]; then
    echo "==> RootFS not found. Running FEXRootFSFetcher..."
    expect /tmp/expect.exp

    echo "==> Installing Steam..."
    FEXBash "/home/steam/Steam/steamcmd.sh"
    
    echo "==> Creating First Time Flag..."
    sudo touch "$FIRST_TIME_FLAG"
else
    echo "==> Not the first time. Skipping..."
fi
    echo "==> Server is ready to start..."

exec "$@"