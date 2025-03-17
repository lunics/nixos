_run_zoxide() {
  zi < $TTY
  l
  echo $(basename "$(dirname $PWD)")/$(basename $PWD)
  zle reset-prompt
}
