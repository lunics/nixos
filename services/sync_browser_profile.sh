#!/usr/bin/env bash

source /home/$1/.nix-profile/etc/profile.d/hm-session-vars.sh       # needed to import $BROWSER

profile_path="/home/${1}/usb_copy/homelab/share/browser/zen"
profile_name="$1"
static="${profile_name}_on_disk"
link="${profile_name}"
volatile="/dev/shm/${BROWSER}_profile_${profile_name}"

IFS=
set -efu
set -x

cd $profile_path

if [ ! -r $volatile ]; then
	mkdir --mode=0700 $volatile
fi

# run once at every startup
if [ "$(readlink $link)" != "$volatile" ]; then
	mv $link $static
	ln -s $volatile $link
fi

if [ -e $link/.unpacked ]; then
	rsync -av --delete --exclude .unpacked ./$link/ ./$static/        # sync ram -> disk
else
	rsync -av ./$static/ ./$link/                                     # sync disk -> ram
	touch $link/.unpacked                                             # create a flag to sync to ram only once
fi
