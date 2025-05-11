
SRC_DIR="/home/src"
HOMECONFIG_DIR="${HOME}/.config"
pathvars=(

$SRC_DIR
projects
PROJECTS_DIR

projects/c.cpp/vcpkg
VCPKG_ROOT

$HOMECONFIG_DIR
yazi/scripts
ySCRIPTS

)
ENV_VARS=(
$SRC_DIR
$HOMECONFIG_DIR
)
pattern=$(IFS=\|; echo "${ENV_VARS[*]}")

typeset -f exportdirs() {
    local length=${#pathvars[@]}
        for ((i=1; i<length; i+=2)); do
            if [[ "${pathvars[i]}" =~ ^($pattern)$ ]]; then
                DIR="${pathvars[i]}"
                ((i-=1)); continue
            fi
            [[ "$DIR" != "/" ]] && local dir="${DIR}/${pathvars[i]}" || local dir="${DIR}${pathvars[i]}"
            local var="${pathvars[i+1]}"
            if [[ "$var" == "$dir" ]]; then continue
            fi
            if [[ -d $dir ]]; then
                export $var=$dir
            elif realdir="$(realpath $dir)"; then
                export $var=$realdir
            else
                echo -e "${pathvars[i]} not found in:\n$DIR"
            fi
    done
}
exportdirs
