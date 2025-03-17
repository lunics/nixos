_open_zoxide() {
  zi < $TTY
  zle reset-prompt
  l
  echo $(basename "$(dirname $PWD)")/$(basename $PWD)
}
