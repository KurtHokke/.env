#!/usr/bin/bash

! command -v gcc &>/dev/null && echo "Can't find gcc" && exit

[[ -z "$1"           \
|| ! -f "$1"         \
|| ! "$1" =~ ^.*\.c$ \
]] && echo "Usage: $0 file.c [args]" && exit 

in="$(realpath "$1")"
out="./$(basename "${in%.c}")"
shift
if gcc "$in" -o "$out"; then
    $out "$@"
fi