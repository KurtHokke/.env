#set -x
optsetter() {
    shopt -s expand_aliases
}
if [[ $# -gt 0 ]]; then
    [[ $1 == "optsetter" ]] && optsetter && return
fi
codium() {
    [[ -f "/usr/bin/codium" ]] \
    && /usr/bin/codium --ozone-platform=wayland "$@" \
    || /usr/bin/code "$@"
}
cp() { local dest
    if [[ "$1" != "--mkdir" ]]; then
        /usr/bin/cp "$@"
        return
    fi
    shift
    case $# in
        2)
            dest="$2"
        ;;
        3)
            dest="$3"
        ;;
        *)
            echo "nothing"; return
        ;;
    esac
    mkdir -p "$dest" && /usr/bin/cp "$@"
}
# shellcheck disable=SC2162
mountvhdx() { local PASSWD=0; local nobackup=0;
    local VHDX="/mnt/win/home/arcno/AppData/Local/wsl/{06af1971-d3bf-4ec0-a8e8-53da9139ef7b}/ext4.vhdx"
    success=-1
    sudo -k
    [[ -n "$1" ]] && PASSWD="$1" && success=0 && shift
    while [[ $success -ne 1 ]]; do
        if [[ $success -eq 0 ]]; then
            echo "$PASSWD" | sudo -S ls &>/dev/null
            if [[ $? -eq 0 ]]; then
                success=1
                continue
            fi
        fi
        printf "Enter Sudo Password: "
        read PASSWD
        success=0
    done

    if [[ $# -gt 0 ]]; then
        if [[ "$1" == "nobackup" ]]; then
            nobackup=1
        fi
    fi

    if [[ $nobackup -eq 0 ]]; then
        if ! mountpoint -q "/mnt/win"; then
            echo "$PASSWD" | sudo -S mount -t ntfs-3g "/dev/nvme0n1p6" "/mnt/win"
        fi
        if [[ ! -f "$VHDX" ]]; then
            echo "FAILED TO FIND VHDX"
            return
        fi
        printf "backing up volume..."
        if [[ -f "/mnt/wsl/ext4.vhdx" ]]; then
            echo "$PASSWD" | sudo -S rm "/mnt/wsl/ext4.vhdx"
        fi
        if [[ $? -eq 0 ]]; then
            echo "$PASSWD" | sudo -S cp "$VHDX" "/mnt/wsl/ext4.vhdx"
            [[ $? -ne 0 ]] && printf " SOMETHING WENT WRONG!!!\n" && return || \
            printf " done!\n"
        else
            printf " SOMETHING WENT WRONG!!!\n"
            return
        fi
    fi
    if ! mountpoint -q "/mnt/wsl/root"; then
        printf "mounting volume..."
        [[ ! -f "/mnt/wsl/ext4.vhdx" ]] && echo "/mnt/wsl/ext4.vhdx doesnt exist!" && return
        echo "$PASSWD" | sudo -S guestmount --add "/mnt/wsl/ext4.vhdx" -i --rw -o allow_other "/mnt/wsl/root"
        [[ $? -ne 0 ]] && printf " SOMETHING WENT WRONG MOUNTING!!!\n" && return || \
        printf " done!\n"
        echo "$PASSWD" | sudo -S umount "/mnt/win"
    else
        echo "\"/mnt/wsl/root\" is already mounted"
    fi
}

runinbg() { local exe="$1"; local args=""
    if [[ -n "$2" ]]; then
        shift
        for arg in "$@"; do
            args=$(printf '%s%s' "$args" "$arg ")
        done
    fi
    (exec "$exe" $args &>/dev/null &)
}
tar-use-zstd() { local OPTS="$1"; local TARNAME="$2"; local OPTIONAL_DIR="$3"
    [[ -n "$OPTS" && -n "$TARNAME" ]] || return 1
    [[ $OPTS =~ ^-.* ]] || OPTS="-${OPTS}"

    if [[ -z "$OPTIONAL_DIR" ]]; then
        tar --zstd "${OPTS}" "${TARNAME}" || return 1
        return 0
    fi
    [[ -d "$(realpath "$OPTIONAL_DIR")" ]] || return 1
    tar --zstd "${OPTS}" "${TARNAME}" "$(realpath "$OPTIONAL_DIR")" || return 1
    return 0
}
cp-per-line() { local file; local dest
    if [[ ! -f "$(realpath "$1")" ]]; then
        echo "$1 doesnt exist"
        return
    elif [[ ! -d "$(realpath "$2")" ]]; then
        echo "$2 doesnt exist or is not a dir"
        return
    fi
    file="$(realpath "$1")"
    dest="$(realpath "$2")"
    [[ -n "$file" && -d "$dest" ]] || return 1
    while IFS= read -r file_per_line; do
        cp "$file_per_line" "${dest}/" &&\
        echo "cp $file_per_line "${dest}/"" ||\
        echo "FAIL: cp $file_per_line "${dest}/""
    done < <(cat "$file")
    return 0
}
rustcandrun() {
    [[ -n $1 ]] || return
    local exe="${1%%.rs}"
    rustc "$(realpath "$1")" &&\
    "$(realpath "$exe")"
}

gitpush() {
    git add .
    local exitstatus=$?
    [[ $exitstatus -ne 0 ]] && echo "something went wrong! exit-status: $exitstatus" && return $exitstatus
    git commit --allow-empty -m "[any message]"
    git push origin master
}
newsship() {
    echo "$1" > $HOME/.sship
    export SSHIP="$1"
}
sshu() 	{
	if [ -n "$SSHIP" ]; then ssh ubuntu@$SSHIP; else echo 'SSHIP=""'
	fi
}
sshuc() 	{
	if [ -n "$SSHIP" ]; then ssh ubuntu@$SSHIP -L 8188:localhost:8188; else echo 'SSHIP=""'
	fi
}
scphere() {
    if [[ -n $2 ]]; then
        scp ubuntu@$SSHIP:/home/ubuntu/$1 $2
    else
        scp ubuntu@$SSHIP:/home/ubuntu/$1 .
    fi
}
scpthere() {
  if [[ -n $2 ]]; then
    scp $1 ubuntu@$SSHIP:/home/ubuntu/$2
  else
    scp $1 ubuntu@$SSHIP:/home/ubuntu/
  fi
}

hex() {
  emulate -L zsh
  if [[ -n "$1" ]]; then
      printf "%x\n" $1
  else
      print 'Usage: hex <number-to-convert>'
      return 1
  fi
}
dec() {
  emulate -L zsh
  if [[ -n "$1" ]]; then
      printf "%d\n" "$((16#$1))"
  else
      print 'Usage: hex_to_dec <hexadecimal-number>'
      return 1
  fi
}
y() {
    # shellcheck disable=SC2155
    local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
    yazi "$@" --cwd-file="$tmp"
    if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
        if ! builtin cd -- "$cwd"; then
            rm -f -- "$tmp"
            return
        fi
    fi
    rm -f -- "$tmp"
}
# shellcheck disable=SC2155
questionmark() {
	if command -v which "$1" &>/dev/null; then
		local using="$(printf "\e[1;38;5;46m%s\e[0m" "$(which "$1")")"
		local other=$(whereis "$1")
		local other="$(echo "$other" | sed 's/'"$1"': //')"
		local other="$(echo "$other" | sed 's/ /\\n/')"
		echo -e "$using\n\n$other"
	else
		echo "$1 not found"
	fi
}
plap() {
  emulate -L zsh
  if [[ $# = 0 ]] ; then
      echo "Usage:    $0 program"
      echo "Example:  $0 zsh"
      echo "Lists all occurrences of program in the current PATH."
  else
      ls -l ${^path}/*$1*(*N)
  fi
}
ncdu() {
    sudo /usr/bin/wrapper/ncdu "$@"
}
identifypngfunction() { local path
    if [[ -z $1 ]]; then
        /usr/bin/identify -format "%f: %wx%h\n" ./*.png
    elif [[ -d $1 ]]; then
        path="$(dirname $1)/$(basename $1)"
        /usr/bin/identify -format "%f: %wx%h\n" ${path}/*.png
    else
        echo "$1 is not an existing path"
    fi
}
# shellcheck disable=SC2124,SC2155,SC2034
echovariable() {
    local echovar="$@"  # Directly assign the first argument to echovar
    if [[ "$echovar" == *":"* ]] || [[ "$echovar" == *" "* ]]; then
        if [[ "$echovar" == *" "* ]]; then
        	local echovar_nl="$(echo "$echovar" | sed -E 's/ /\n/g')"
        else
	        # Remove leading ':' and replace ':' with newlines
	        local echovar_nl="$(echo "$echovar" | sed -E 's/^://; s/:/\n/g')"
	    fi
        
        # Declare an associative array
        typeset -A line_map

        # Iterate through each line and store in associative array
        for line in ${(f)echovar_nl}; do
        	if [[ -d "$line" ]]; then
        		if [[ "$(realpath $line)" == "$line" ]]; then
	            line_map["$line"]="$(printf "\e[1;38;5;27m%s\e[0m\n" "$line")"
          	else
          		line_map["$line"]="$(printf "\e[1;38;5;87m%s\e[0m\e[38;5;229m --> \e[0m\e[1;38;5;27m%s\e[0m\n" "$line" "$(realpath $line)")"
          	fi
          elif [[ -f "$line" ]]; then
        		if [[ "$(realpath $line)" == "$line" ]]; then
	            line_map["$line"]="$(printf "\e[1m%s\e[0m\n" "$line")"
          	else
          		line_map["$line"]="$(printf "\e[1m%s\e[0m\e[38;5;229m --> \e[0m\e[1m%s\e[0m\n" "$line" "$(realpath $line)")"
          	fi
          else
          	if [[ ! -e "$line" ]]; then
	          	line_map["$line"]="$(printf "\e[1;38;5;196m%s\e[0m\n" "$line")"
          	else
          		line_map["$line"]="$(printf "\e[1m%s\e[0m\n" "$line")"
          	fi
          fi
        done
        
        # Accessing the associative array 
        for key in "${(@k)line_map}"; do  # Use @k to get keys
            echo "${line_map[$key]}"  # Access value using key
        done
    else
        echo "$echovar"
    fi
}
syncmypath() {
    MYPATH="${HOME}/bin"
    [[ ! -d "$MYPATH" || -d "/mnt/wslg/distro" ]] && return
    for MYFILE in "$MYPATH"/*; do
        if [[ ! -x "$MYFILE" ]]; then chmod +x "$MYFILE"
        fi
    done
    for mysubp in "$MYPATH"/*; do
        if [[ -d "$mysubp" ]]; then
            if [[ ! -z "$(ls -A "$mysubp")" ]]; then
                MYPATH="${MYPATH}:${mysubp}"
              for myfile in "$mysubp"/*; do
                if [[ -d $myfile ]]; then
                    mySUBsubP="$myfile"
                    if [[ ! -z "$(ls -A "$mySUBsubP")" ]]; then
                          MYPATH="${MYPATH}:${mySUBsubP}"
                        for mySUBsubF in "$mySUBsubP"/*; do
                            if [[ ! -x "$mySUBsubF" ]]; then
                              chmod +x "$mySUBsubF"
                            fi
                          done
                        fi
                  fi
                if [[ ! -x "$myfile" ]]; then chmod +x "$myfile"
                fi
              done
            fi
        fi
    done
    export MYPATH
}
makecompletionfile() {
    if [[ "$1" != "_"* ]]; then
        local func="_${1}"
    else
        local func="${1}"
    fi
echo -e "\
${func}() {\n  local state\n\n  _arguments \\ \n    '1: :->aws_profile'\\ \n    '*: :->eb_name'\n\n  case \$state in\n    (aws_profile) _arguments '1:profiles:(cuonglm test)' ;;\n              \
(*) compadd \"\$@\" prod staging dev\n  esac\n}\n\n${func} \"\$@\"" > "${ZDOTDIR}/completions.usr/${func}"
}

