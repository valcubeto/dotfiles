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

if ask "Create hard links for Bash files?"; then
    # -p: No error when the folder already exists.
    # -v: Output folder names when created.
    mkdir -v -p bash
    # -v: Output hard link names when created.
    # -t <dir> <files...>: create a hard link
    #                      to <files...> into <dir>
    ln -v -t bash \
        $HOME/.bashrc \
        $HOME/.bash_aliases
fi

if ask "Create hard links for Starship files?"; then
    mkdir -v -p starship
    ln -v -t starship \
        $HOME/.config/starship.toml
fi

if ask "Create hard links for Alacritty files?"; then
    # -p: No error, and also creates needed parent folders.
    mkdir -v -p alacritty/themes/
    ln -v -t alacritty/ \
        $HOME/.config/alacritty/alacritty.toml
    ln -v -t alacritty/themes/ \
        $HOME/.config/alacritty/themes/vega.toml
fi

if ask "Create hard links for VS Codium files?"; then
    mkdir -v -p codium/
    ln -v -t codium/ \
        $HOME/.config/VSCodium/User/settings.json
fi
