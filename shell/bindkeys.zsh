zle -N _open_all
bindkey '^F' _open_all            # ctrl f = fd + yazi

bindkey -s '^o' 'lfcd\n'          # ctrl o = file explorer with lf
bindkey -s '^w' 'exit\n'
