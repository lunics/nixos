#!/bin/env bash

# filename=$(basename -- "$1")
# extension="${filename##*.}"
# basename="${filename%.*}"

# old: utilisé avant de découvrir devour
# run the program in background then detach it from the current shell
# detach (){
#   $@ &
#   sleep 0.2
#   disown %$(jobs | grep -Po "(?<=\[).*?(?=\])")
# }

[ -f "$1" ] && {
  case $1 in
    *.pdf)    devour zathura $* ;;
    *.epub)   devour zathura $* ;;
    *.png)    firefox $*        ;;      ## remplacer par un vrai lecteur
    ## *.jpg)    ?reader? $*       ;;
    *.gif)    sxiv -a $*        ;;
    *.mkv)    devour mpv $*     ;;
    *.webm)   devour mpv $*     ;;
    *.ods)    libreoffice $* &  ;;
    *.odg)    libreoffice $* &  ;;
    *.odt)    libreoffice $* &  ;;
    *.txt)    $EDITOR $*        ;;
    *.md)     glow -p $*        ;;
    *.sh)     $EDITOR $*        ;;
    *.c)      $EDITOR $*        ;;
    *)        $EDITOR $*        ;;
  esac
}
