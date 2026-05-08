_bypass_wordchars (){
  local save_wordchars="$WORDCHARS"
  WORDCHARS=""
  zle backward-kill-word
  WORDCHARS="$save_wordchars"
}
