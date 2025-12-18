zle -N _expand_aliases
bindkey '^E' _expand_aliases        # ctrl e = expand alias

zle -N _open_all
bindkey "^F" _open_all              # ctrl f = fd + yazi

zle -N _run_lazygit
bindkey "^G" _run_lazygit           # ctrl g = lazygit

bindkey -s "^L" "clear\n"           # ctrl l = clear

zle -N _run_yazi
bindkey '^I' _run_yazi              # tab when prompt is empty to run yazi

zle -N _run_pass
bindkey '^P' _run_pass              # ctrl p = passage + fzf

bindkey -s "^O" "lfcd\n"            # ctrl o = file explorer with lf

zle -N _run_taskfile
bindkey '^T' _run_taskfile          # ctrl t = taskfile + fzf

bindkey -s "^W" "exit\n"

zle -N _run_zoxide
bindkey "^Z" _run_zoxide            # ctrl z = zoxide + fzf

bindkey "^[[1;5D" backward-word
bindkey "^[[1;5C" forward-word

bindkey "^H" backward-kill-word     # ctrl backspace = delete word before (respecting WORDCHARS)

# zle -N _bypass_wordchars
# bindkey "" _bypass_wordchars      # ctrl shift backspace = delete word before (ignoring WORDCHARS)

# ^[[Z  # shit tab
