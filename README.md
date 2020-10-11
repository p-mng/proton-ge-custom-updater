## Proton updater scripts

Simple shell scripts to automatically download and install the latest modified Proton distributions by [GloriousEggroll](https://github.com/GloriousEggroll/proton-ge-custom) and [TKG](https://github.com/Frogging-Family/wine-tkg-git).

If you want to use the scripts with non-POSIX shells like fish, run it using the `sh ./proton-ge-custom-updater.sh` command.

![repo size](https://img.shields.io/github/repo-size/patrickm32/proton-ge-custom-updater) ![license](https://img.shields.io/github/license/patrickm32/proton-ge-custom-updater) ![last update](https://img.shields.io/github/last-commit/patrickm32/proton-ge-custom-updater) ![stars](https://img.shields.io/github/stars/patrickm32/proton-ge-custom-updater?style=social)

## Dependencies

- POSIX-compliant shell (e.g. bash)
- GNU coreutils (busybox may also work but is not supported)
- `curl`
- `unzip` for the proton-tkg updater

## Possible improvements

- Add support for compiling the source code locally
- Create AUR package for easier updates
