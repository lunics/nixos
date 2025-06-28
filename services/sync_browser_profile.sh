#!/usr/bin/env bash

profile_path="/home/lunics/usb_copy/homelab/share/browser/zen"
profile_name="lunics"
static="${profile_name}_on_disk"
link="${profile_name}"
# volatile="/dev/shm/${BROWSER}_profile_$1"
volatile="/dev/shm/${BROWSER}_profile_${profile_name}"

IFS=
set -efu
set -x

cd $profile_path

if [ ! -r $volatile ]; then
	mkdir --mode=0700 $volatile
fi

if [ "$(readlink $link)" != "$volatile" ]; then
	mv -v $link $static
  echo "1er IF: MV $link $static"
	ln -s $volatile $link
fi

if [ -e $link/.unpacked ]; then
	rsync -av --delete --exclude .unpacked ./$link/ ./$static/
  echo "SYNC link -> static"
else
	rsync -av ./$static/ ./$link/
	touch $link/.unpacked
  echo "SYNC static -> link"
fi
