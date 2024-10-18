#!/bin/env bash

[ -f $1 ] && {
  case $1 in
    *.tar.bz2)   tar xvjf $1   ;;
    *.tar.gz)    tar xvzf $1   ;;
    *.tar.xz)    tar xvJf $1   ;;
    *.bz2)       bunzip2 $1    ;;
    *.rar)       unrar x $1    ;;
    *.tgz)       tar xvf $1    ;;
    *.gz)        gunzip $1     ;;
    *.tar)       tar xf $1     ;;
    *.tbz2)      tar xjf $1    ;;
    *.zip)       unzip $1 -d ${1%.*} ;;
    *.Z)         uncompress $1 ;;
    *.7z)        7z x $1       ;;
    *)           echo "'$1' cannot be extracted via ex()" ;;
  esac
  { echo -e "\nls -l $(pwd)\n"; exa -l --group-directories-first; } || ls -l
} || {
  echo "'$1' is not a valid file"
}
