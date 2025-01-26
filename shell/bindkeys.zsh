zle -N _open_all
bindkey "^F" _open_all                # ctrl f = fd + yazi

zle -N _open_zoxide
bindkey "^Z" _open_zoxide             # ctrl z = zoxide + fzf

zle -N _open_yazi
bindkey '^I' _open_yazi               # tab when prompt is empty to run yazi

bindkey -s "^o" "lfcd\n"              # ctrl o = file explorer with lf
bindkey -s "^w" "exit\n"

bindkey "^[[1;5D" backward-word
bindkey "^[[1;5C" forward-word

bindkey "^[^?" backward-kill-word     # alt backspace = delete word before
