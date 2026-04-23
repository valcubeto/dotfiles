set -e

fatal() {
    printf "Fatal: $1\n" >&2
    exit 1
}

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
            echo "Unrecognized answer" >&2
            # Prompt until valid answer.
            ask "$1"
            return $?
            ;;
    esac
}

copy_if_needed() {
    local target="$1"
    local files="${@:2}"
    local dest

    mkdir --verbose --parents "$target"

    for file in $files; do
        if [[ ! -f $file ]]; then
            fatal "Path \"$file\" is not a file."
        fi

        dest="$target/$(basename "$file")"

        if ! cmp --quiet "$file" "$dest"; then
            cp --verbose "$file" "$dest"
        fi
    done
}
