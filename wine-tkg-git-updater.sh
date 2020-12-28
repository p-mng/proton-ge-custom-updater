#!/bin/sh

# Find the latest release url and filename (just like in the other scripts)
url="$(curl -s 'https://api.github.com/repos/Frogging-Family/wine-tkg-git/releases/latest' | grep 'browser_download_url' | grep 'staging' | cut -d \" -f 4)"
filename="$(echo $url | sed 's|.*/||')"

# Download the latest version
# Technically pacman could directly download and install but that would require a change in the pacman.conf file and thus more hassle
echo "--> Downloading the latest wine-tkg..."
curl -LOJ "$url"

if [ "$(id -u)" = "0" ]; then
	echo "--> Installing as root..."
	pacman -U "$filename"
elif [ $(which sudo) ]; then
	echo "--> Not running as root. Trying to elevate through sudo..."
	sudo pacman -U "$filename"
else
	echo "--> Error: Please run the script with root privileges."
fi

# Cleanup
echo "--> Cleaning up..."
rm "$filename"
