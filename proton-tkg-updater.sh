#!/bin/sh

# This script is a forked and adjusted version from the Proton-GE-Custom updater

# Get the latest Proton-tkg release (url and filename)
url="$(curl -s "https://api.github.com/repos/Frogging-Family/wine-tkg-git/releases/latest" | grep "browser_download_url" | grep "proton" | cut -d \" -f 4)"
filename="$(echo "$url" | sed "s|.*/||")"

# Installation routine
install() {
    # Check if the given folder exists, exit function if this is not the case
    if [ ! -d "$1" ]; then
        return 1
    fi
    # cd into the given path
    cd "$1"
    # Check if Steam is installed in current folder or if the script has to follow a symlink (usually in ~/.steam)
    # only relevant for some distros/versions (issue 3)
    if [ ! -f "steam.sh" ]; then
        # Follow symlink if there is no steam.sh
        if [ ! -f "./steam/steam.sh" ]; then
            echo "--> steam.sh could not be found. Please make sure Steam is properly installed."
            return 1
        fi
        cd "steam"
    fi
    # Check if compatibilitytools.d folder exists, if not create it
    if [ ! -d "compatibilitytools.d" ]; then
        echo "--> Creating folder for Steam compatibility tools..."
        mkdir "compatibilitytools.d"
    fi
    cd "compatibilitytools.d"
    # Check if current release is already installed
    if [ -d "$(echo "$filename" | sed "s|\.tar\..*||")" ]; then
        echo "--> Current version is already installed."
        return 0
    else
        # Download latest release, extract the files and delete the archive
        echo "--> Downloading $filename..."
        curl -L "$url" --output "$filename"
        echo "--> Extracting $filename..."
        mkdir "$(echo "$filename" | sed "s|\.tar\..*||")"
        tar -xf "$filename" -C "$(echo "$filename" | sed "s|\.tar\..*||")"
        echo "--> Removing the compressed archive..."
        rm "$filename"
        echo "--> Done. Please check the command line for errors and restart Steam for the changes to take effect."
        return 0
    fi
}

# Check if steam is installed regularly, either in one of the two locations
if [ -d "$HOME/.local/share/Steam" ] || [ -d "$HOME/.steam" ]; then
    echo "--> Regular Steam installation found. Installing..."
    install "$HOME/.local/share/Steam" || install "$HOME/.steam"
else
    echo "--> Steam does not seem to be installed as a regular package. No changes were made."
fi

# Check if steam is installed as Flatpak
if [ -d "$HOME/.var/app/com.valvesoftware.Steam/.local/share/Steam" ] || [ -d "$HOME/.var/app/com.valvesoftware.Steam/.steam" ]; then
    echo "--> Flatpak Steam installation found. Installing..."
    install "$HOME/.var/app/com.valvesoftware.Steam/.local/share/Steam" || install "$HOME/.var/app/com.valvesoftware.Steam/.steam"
else
    echo "--> Steam does not seem to be installed as Flatpak. No changes were made."
fi
