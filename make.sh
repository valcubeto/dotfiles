#!/bin/env bash

mkdir -pv bash
ln -v $HOME/.bashrc -t bash
ln -v $HOME/.bash_aliases -t bash

mkdir -pv alacritty/themes
ln -v $HOME/.config/alacritty/alacritty.toml -t alacritty
ln -v $HOME/.config/alacritty/themes/vega.toml -t alacritty/themes

mkdir -pv codium
ln -v $HOME/.config/VSCodium/User/settings.json -t codium
