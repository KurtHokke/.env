ZDOTDIR="$HOME/.zsh"
fpath+=(${ZDOTDIR}/completions.usr)

if uwsm check may-start && uwsm select; then
	exec uwsm start default
fi
