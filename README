# STEAM/FEX

This is a straightforward Docker container designed to run Steam on AArch64 (ARM64) systems using FEX for x86 emulation.
It can serve as a foundation and be adapted for running various Steam games or dedicated servers.

---

## Features

- Run Steam client on AArch64 (ARM64) via FEX emulation
- Easily customizable for specific game containers or server setups
- Minimal container footprint
- Works on most modern ARM64 Linux systems with Docker support
- *(Optional)* Docker network configuration for use with **Caddy**

---

## Requirements

- A Linux system with an ARM64 (AArch64) processor
- Docker installed and running
- Basic familiarity with Docker and the command line

> ⚠️ **Note:** Performance will depend heavily on your hardware and the demands of the emulated applications.

---

## Getting Started

1. Clone this repo
```bash
git clone https://github.com/GladeOwl/steamfex.git
```

2. Build the image.
```bash
sudo docker compose build .
```
> ⚠️ **Note:** This can take a while.

3. Run the container
```bash
sudo docker compose up -d
```

---

## Adapting to a specific game. 

> You can edit the steamcmd.sh command in the ``entrypoint.sh`` to install the specific game server.
```bash
# example for a Valheim server
FEXBash "/home/steam/Steam/steamcmd.sh +force_install_dir ~/Steam/valheim +login anonymous +app_update 896660 validate +quit"
```