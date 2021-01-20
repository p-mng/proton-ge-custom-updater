#!/bin/sh

# Find the latest release url and filename (just like in the other scripts)
url="$(curl -s 'https://api.github.com/repos/Frogging-Family/wine-tkg-git/releases/latest' | grep 'browser_download_url' | grep 'staging' | cut -d \" -f 4)"
filename="$(echo '$url' | sed 's|.*/||')"

# Optionally download the package/do not directly install from remote
# (not needed when directly installing using pacman)
# curl -LOJ "$url"

# Download the latest version and install it using pacman
echo "--> Downloading and installing the latest wine-tkg..."

if [ "$(id -u)" = "0" ]; then
	echo "--> Installing as root..."
	echo -e "\e[90m"
	pacman --needed -U "$url"
	echo -e "\e[0m"
elif [ $(which sudo) ]; then
	echo "--> Not running as root. Trying to elevate through sudo..."
	echo -e "\e[90m"
	sudo pacman --needed -U "$url"
	echo -e "\e[0m"
else
	echo "--> Error: Please run the script with root privileges."
fi

# Cleanup (not needed when directly installing using pacman)
# echo "--> Cleaning up..."
# rm "$filename"
