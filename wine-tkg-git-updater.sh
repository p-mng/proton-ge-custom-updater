#!/bin/sh

# Find the latest release url and filename (just like in the other scripts)
url="$(curl -s "https://api.github.com/repos/Frogging-Family/wine-tkg-git/releases/latest" | grep "browser_download_url" | grep "staging" | cut -d \" -f 4)"
filename="$(echo "$url" | sed "s|.*/||")"

# Check if cache dir exists
if [ ! -d "$HOME/.cache/wine-tkg-git-updater" ]; then
	mkdir -p "$HOME/.cache/wine-tkg-git-updater"
fi

# Check if current version was alredy downloaded, and if not do so
if [ ! -f "$HOME/.cache/wine-tkg-git-updater/$filename" ]; then
	echo "--> Downloading..."
	curl -L "$url" -o "$HOME/.cache/wine-tkg-git-updater/$filename"
else
	echo "--> Current version has already been downloaded. Trying to install anyway..."
fi
	
# Install the package
if [ "$(id -u)" = "0" ]; then
    echo "--> Installing as root..."
    echo
    pacman --needed -U "$HOME/.cache/wine-tkg-git-updater/$filename"
    echo
elif [ "$(which sudo)" ]; then
    echo "--> Not running as root. Trying to elevate through sudo..."
    echo
    sudo pacman --needed -U "$HOME/.cache/wine-tkg-git-updater/$filename"
    echo
else
    echo "--> Error: Please run the script with root privileges."
fi
