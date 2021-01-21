#!/bin/sh

# Find the latest release url and filename (just like in the other scripts)
url="$(curl -s "https://api.github.com/repos/Frogging-Family/wine-tkg-git/releases/latest" | grep "browser_download_url" | grep "staging" | cut -d \" -f 4)"

# Download the latest version and install it using pacman
echo "--> Downloading and installing the latest wine-tkg..."

if [ "$(id -u)" = "0" ]; then
    echo "--> Installing as root..."
    echo
    pacman --needed -U "$url"
    echo
elif [ "$(which sudo)" ]; then
    echo "--> Not running as root. Trying to elevate through sudo..."
    echo
    sudo pacman --needed -U "$url"
    echo
else
    echo "--> Error: Please run the script with root privileges."
fi
