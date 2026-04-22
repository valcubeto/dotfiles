ask() {
    # Make this variable local, meaning it will only exist
    # inside this function.
    local word
    # `-p` is for "prompt".
    read -p "$1 (y/N) " word
    # If the variable is empty, use `N` as the default value.
    case "${word:-N}" in
        [Yy]) return 0 ;;
        [Nn]) return 1 ;;
        *)
            printf "Unrecognized answer, skipping.\n" >&2
            return 2
            ;;
    esac
}
