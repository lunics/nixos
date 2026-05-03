_expand_aliases (){
  # Clear autosuggestions (zsh-autosuggestions plugin)
  zle autosuggest-clear 2> /dev/null

  if [[ $LBUFFER =~ '(^|[[:space:]])([^[:space:]]+)$' ]]; then
    local word=${BASH_REMATCH[2]}
    if alias $word >/dev/null 2>&1; then
      zle _expand_alias
      return              # prevents ^E from being inserted
    fi
  fi

  zle self-insert         # insert the space
}
