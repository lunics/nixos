#!/usr/bin/env bash

# fzf search/open directories
fd () {
  local dir=
  dir=$(find ~/ -path '*/\.*' -prune -o \( -type d -o -type l \) -print 2> /dev/null | fzf +m) && \
  yazi ${dir}
}
