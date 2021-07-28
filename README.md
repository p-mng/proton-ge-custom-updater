## Proton updater scripts

Simple shell scripts to automatically download and install the latest modified Proton distributions by [GloriousEggroll](https://github.com/GloriousEggroll/proton-ge-custom) and [TkG](https://github.com/Frogging-Family/wine-tkg-git). `wine-tkg-git` is also supported (Arch Linux only).

If you want to use the scripts with non-POSIX shells like fish, run them using the `sh ./proton-ge-custom-updater.sh` command.

![repo size](https://img.shields.io/github/repo-size/p-mng/proton-ge-custom-updater?style=for-the-badge) ![license](https://img.shields.io/github/license/p-mng/proton-ge-custom-updater?style=for-the-badge) ![last update](https://img.shields.io/github/last-commit/p-mng/proton-ge-custom-updater?style=for-the-badge) ![stars](https://img.shields.io/github/stars/p-mng/proton-ge-custom-updater?style=for-the-badge&logo=github) ![codacy grade](https://img.shields.io/codacy/grade/758ff7ed45904f2b8089acdb44f77b73?style=for-the-badge&logo=codacy)

## Dependencies

- POSIX-compliant shell (e.g. bash)
- GNU coreutils (busybox may also work but is not supported)
- `curl`
- `pacman` for wine-tkg-git updater
- `tar`
- `unzip` for proton-tkg updater

## Possible improvements

- Create AUR package for easier updates
- Automatically update steam configurations and remove old versions
