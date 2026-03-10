#!/bin/env bash

ask() {
    # Make this variable local, meaning it will only exist
    # inside this function.
    local word
    # `-p` is for "prompt"
    read -p "$1 (y/N) " word
    # If the variable is empty, use `N` as the default value.
    word="${word:-N}"
    # Self explanatory.
    case "$word" in
        [Yy]) return 0 ;;
        [Nn]) return 1 ;;
        *)
            printf "Unrecognized answer: \"$word\". Skipping.\n" >&2
            return 2
            ;;
    esac
}

if ask "Restore Bash config files?"; then
    # -i: Prompt before overwrite.
    # -t <dir> <files...>: move all files into dir
    cp -i -t $HOME/ \
        bash/.bashrc \
        bash/.bash_aliases
fi

if ask "Restore Starship config files?"; then
    mkdir -v -p $HOME/.config
    cp -i -t $HOME/.config \
        starship/starship.toml
fi

if ask "Restore Alacritty config files?"; then
    # -p: No error, and also creates needed parent folders.
    mkdir -v -p $HOME/.config/alacritty/themes/
    cp -i -t $HOME/.config/alacritty/ \
        alacritty/alacritty.toml
    cp -i -t $HOME/.config/alacritty/themes/ \
        alacritty/themes/vega.toml
fi

if ask "Restore VSCodium config files?"; then
    mkdir -v -p $HOME/.config/VSCodium/User/
    cp -i -t $HOME/.config/VSCodium/User/ \
        codium/settings.json
fi

if ask "Restore Git config?"; then
    # Avoid using master.
    git config --global init.defaultBranch main
fi
