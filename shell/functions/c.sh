#!/usr/bin/env bash

# can only run in function or alias no as executable (else cd will run in sub shell then quit)
c (){
  ## SI la cible est un fichier ALORS go to parent directory
  # cd `dirs -v | cut -f 2 | fzf`
  # cd parent dir of the file
  
  if [[ $# -eq 0 ]]; then
    cd $HOME
  else
    formated=$(echo ${*} | sed "s/[\]//g")

    z "$(realpath $formated)" && exa -l --group-directories-first --git-repos --hyperlink
  fi
}
