CFLAGS=("-Wall" "-Wextra" "-Wpedantic" "-g" "-O0" "-std=gnu11")
SCRIPT_DIR=$(realpath "$(dirname "$0")")

cmakebuild()
{
    [[ -d "$SCRIPT_DIR/build" ]] && rm -rf "$SCRIPT_DIR/build"
    mkdir -p "$SCRIPT_DIR/build"
    cd "$SCRIPT_DIR/build" && cmake "$@" .. || return
}

build()
{
    [[ $# -eq 0 ]] && return
    if gcc "${CFLAGS[@]}" "$@" -o main; then
        printf "\n\e[36;5;38mgcc exited 0\e[0m\n"
    fi
}

memtest()
{
    valgrind --leak-check=full "$@"
}

export CFLAGS=("${CFLAGS[@]}")
