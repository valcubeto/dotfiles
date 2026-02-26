#!/bin/env bash

# -i: Prompt before overwrite.
# -t <dir> <files...>: move all files into dir
cp -i -t $HOME/ \
    bash/.bashrc \
    bash/.bash_aliases

# -p: No error, and also creates needed parent folders.
mkdir -v -p $HOME/.config/alacritty/themes/
cp -i -t $HOME/.config/alacritty/ \
    alacritty/alacritty.toml
cp -i -t $HOME/.config/alacritty/themes/ \
    alacritty/themes/vega.toml

mkdir -v -p $HOME/.config/VSCodium/User/
cp -i -t $HOME/.config/VSCodium/User/ \
    codium/settings.json
