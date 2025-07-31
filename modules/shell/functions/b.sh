#!/usr/bin/env bash

b (){
  local d=""
  limit=$1

  for ((i=1 ; i <= limit ; i++)) do
    d=$d/..
  done

  d=$(echo $d | sed 's/^\///')

  if [ -z "$d" ]; then   # if no args then just 1 back
    c ..
  else
    c $d
  fi
}
