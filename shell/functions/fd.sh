#!/usr/bin/env bash

# fzf search/open directories
fzfind () {
  local dir=
  dir=$(find ~/ -path '*/\.*' -prune -o \( -type d -o -type l \) -print 2> /dev/null | fzf +m) && \
  yazi ${dir}
}
