#!/bin/env bash

# -p: No error when the folder already exists.
# -v: Output folder names when created.
mkdir -v -p bash
# -v: Output hard link names when created.
# -t <dir> <files...>: create a hard link
#                      to <files...> into <dir>
ln -v -t bash \
    $HOME/.bashrc \
    $HOME/.bash_aliases

# -p: No error, and also creates needed parent folders.
mkdir -v -p alacritty/themes/
ln -v -t alacritty/ \
    $HOME/.config/alacritty/alacritty.toml
ln -v -t alacritty/themes/ \
    $HOME/.config/alacritty/themes/vega.toml

mkdir -v -p codium/
ln -v -t codium/ \
    $HOME/.config/VSCodium/User/settings.json
