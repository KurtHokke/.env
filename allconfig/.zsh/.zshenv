ZDOTDIR="$HOME/.zsh"
fpath+=(${ZDOTDIR}/completions.usr)

if uwsm check may-start &>/dev/null && uwsm select &>/dev/null; then
	exec uwsm start default
fi
