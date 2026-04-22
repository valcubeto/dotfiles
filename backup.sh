#!/bin/env bash

source utils.sh

set -e

if ask "Copy Bash files?"; then
    # --parents: No error when the folder already exists.
    copy_if_needed \
        bash/ \
        "$HOME/.bashrc" \
        "$HOME/.bash_aliases"
fi

if ask "Copy Starship files?"; then
    copy_if_needed \
        starship/ \
        "$HOME/.config/starship.toml"
fi

if ask "Copy Alacritty files?"; then
    copy_if_needed \
        "alacritty/" \
        "$HOME/.config/alacritty/alacritty.toml"
    copy_if_needed \
        "alacritty/themes/" \
        "$HOME/.config/alacritty/themes/vega.toml"
fi

if ask "Copy VSCodium files?"; then
    copy_if_needed \
        "codium/" \
        "$HOME/.config/VSCodium/User/settings.json"
fi
