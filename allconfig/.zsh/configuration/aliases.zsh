
#alias -g BG='& exit'
#alias -g C='|wc -l'
#alias -g G='|grep'
#alias -g H='|head'
#alias -g J='|jq'
#alias -g K='|keep'
#alias -g L='|less'
#alias -g LL='|& less -r'
#alias -g M='|most'
#alias -g N='&>/dev/null'
#alias -g R='| tr A-z N-za-m'
#alias -g SL='| sort | less'
#alias -g S='| sort'
#alias -g T='|tail'
#alias -g V='| vim -'

alias lazy='NVIM_APPNAME=LazyVim XDG_DATA_HOME=/home/src nvim'

alias la='ls -lah'
alias ls.ss='ls --sort=size -1 -Ar'
alias la.ss='ls --sort=size -1 -lAhr'

alias -g -- \$='echovariable'
alias pacS='sudo pacman -S'
alias pacU='sudo pacman -U'
alias pacR='sudo pacman -R'
alias pacQs='pacman -Qs'
alias pacgrep='pacman -Qs | grep'
alias pacSyu='sudo pacman -Syu'
alias gpro-led='sudo /usr/bin/wrapper/gpro-led '

alias '...'='../..'
alias '....'='../../..'

alias docom='docker compose'
alias docomx='docker compose exec comfyui'
alias docomxc='docker compose exec copy_comfyui'
alias top10='print -l ${(o)history%% *} | uniq -c | sort -nr | head -n 10'
alias -- subl.z='subl -n $ZDOTDIR'
alias -- subl.nodes='subl -n /home/src/python/ComfyUI'
alias -- systemctl.running='systemctl --type=service --state=running'
alias -- tar.pigz='tar --use-compress-program=pigz'
alias -- tarz='tar-use-zstd'
alias -- rust-by-practice='cd "${PROJECTS_DIR}/rust/rust-by-practice" && mdbook serve en/'


alias hyprcfg='nvim ~/.config/hypr/hyprland.conf'
alias nvimcfg='prevloc="$(pwd)"; cd ~/.config/nvim && nvim && cd "$prevloc"'
alias n='nvim '

alias \?='questionmark'
alias sudu='sudo -u $USER'
alias -- -='clear'
alias -- +='exec zsh'

alias u='y'
alias srcenv='src-exec'
alias -- id.png='identifypngfunction'

alias rsrun='rustcandrun'

alias startcomfy='/home/src/comfy/bin/python /home/src/other/ComfyUI/main.py'
