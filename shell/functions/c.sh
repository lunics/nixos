#!/usr/bin/env bash

# can only run in function or alias no in executable (cd will run in sub shell then quit)
c (){
  ## SI la cible est un fichier ALORS go to parent directory
  ## SI IP alors lancer ssh
  # cd `dirs -v | cut -f 2 | fzf`
  # cd parent dir of the file
  ## cd $1 && l         DELETE IF Z OK
  z $(realpath "${1}") && exa -l --group-directories-first --git-repos --hyperlink
}
