#!/usr/bin/env bash

source /home/${1}/.nix-profile/etc/profile.d/hm-session-vars.sh       # needed to import $BROWSER

browser_path="/home/${1}/usb_copy/homelab/share/browser/${BROWSER}"
profile_name="$1"
cache_path_disk="${browser_path}/${1}_cache"
cache_path_ram="/run/user/${UID}/${BROWSER}_cache"
static="${profile_name}_on_disk"
link="${profile_name}"
volatile="/dev/shm/${BROWSER}_profile_${profile_name}"

IFS=
set -efu
set -x

cd $browser_path

if [ ! -r $volatile ]; then
	mkdir --mode=0700 $volatile
fi

# run once at every startup
if [ "$(readlink $link)" != "$volatile" ]; then
	mv $link $static
	ln -s $volatile $link
fi

if [ -e $link/.unpacked ]; then
	rsync -av --delete --exclude .unpacked ./$link/ ./$static/                  # sync profile ram -> disk
	rsync -av --delete --exclude .unpacked $cache_path_ram/ $cache_path_disk/   # sync cache   ram -> disk
else
	rsync -av ./$static/ ./$link/                     # sync profile disk -> ram
	rsync -av $cache_path_disk/ $cache_path_ram/      # sync cache   disk -> ram
	touch $link/.unpacked                             # create a flag to sync to ram only once
fi
