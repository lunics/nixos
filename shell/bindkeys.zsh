zle -N _open_all
bindkey "^F" _open_all                # ctrl f = fd + yazi

zle -N _run_zoxide
bindkey "^Z" _run_zoxide              # ctrl z = zoxide + fzf

zle -N _run_yazi
bindkey '^I' _run_yazi                # tab when prompt is empty to run yazi

zle -N _run_taskfile
bindkey '^T' _run_taskfile            # ctrl t = taskfile + fzf

zle -N _run_pass
bindkey '^P' _run_pass                # ctrl p = passage + fzf

bindkey -s "^o" "lfcd\n"              # ctrl o = file explorer with lf
bindkey -s "^w" "exit\n"

bindkey "^[[1;5D" backward-word
bindkey "^[[1;5C" forward-word

bindkey "^[^?" backward-kill-word     # alt backspace = delete word before
