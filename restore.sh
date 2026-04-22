#!/bin/env bash

source utils.sh

if ask "Restore Bash config files?"; then
    cp  --interactive \
        --target-directory $HOME/ \
        bash/.bashrc \
        bash/.bash_aliases
fi

if ask "Restore Starship config files?"; then
    mkdir --verbose --parents $HOME/.config
    cp  -i \
        -t $HOME/.config \
        starship/starship.toml
fi

if ask "Restore Alacritty config files?"; then
    mkdir -v -p $HOME/.config/alacritty/themes/
    cp  -i \
        -t $HOME/.config/alacritty/ \
        alacritty/alacritty.toml
    cp  -i \
        -t $HOME/.config/alacritty/themes/ \
        alacritty/themes/vega.toml
fi

if ask "Restore VSCodium config files?"; then
    mkdir -v -p $HOME/.config/VSCodium/User/
    cp  -i \
        -t $HOME/.config/VSCodium/User/ \
        codium/settings.json
fi

if ask "Restore Git config?"; then
    # Avoid using master.
    git config --global init.defaultBranch main
fi
