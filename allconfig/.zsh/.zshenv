ZDOTDIR="$HOME/.zsh"
fpath+=(${ZDOTDIR}/completions.usr)

if command -v uwsm &>/dev/null && uwsm check may-start && uwsm select; then
	exec uwsm start default
fi
