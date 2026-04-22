#!/bin/env bash

source utils.sh

if ask "Copy Bash files?"; then
    # --parents: No error when the folder already exists.
    mkdir --verbose --parents bash
    cp  --verbose \
        --target-directory bash \
        $HOME/.bashrc \
        $HOME/.bash_aliases
fi

if ask "Copy Starship files?"; then
    mkdir -v -p starship
    cp  -v \
        -t starship \
        $HOME/.config/starship.toml
fi

if ask "Copy Alacritty files?"; then
    mkdir -v -p alacritty/themes/
    cp  -v \
        -t alacritty/ \
        $HOME/.config/alacritty/alacritty.toml
    cp  -v \
        -t alacritty/themes/ \
        $HOME/.config/alacritty/themes/vega.toml
fi

if ask "Copy VSCodium files?"; then
    mkdir -v -p codium/
    cp  -v \
        -t codium/ \
        $HOME/.config/VSCodium/User/settings.json
fi
