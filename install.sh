#!/usr/bin/env bash

if [[ $EUID -ne 0 ]]; then
    echo "CRITICAL ERROR: Installation requires root privileges. Please run with sudo." >&2
    exit 1
fi

echo "-> Fetching Melina CLI from GitHub..."

curl -sSL "https://raw.githubusercontent.com/sluiys/melina/main/melina" -o /usr/local/bin/melina
chmod +x /usr/local/bin/melina

echo "-> SUCCESS: The 'melina' command is now available on your system."
echo "-> Run 'sudo melina init' to install and activate the fallback shield."