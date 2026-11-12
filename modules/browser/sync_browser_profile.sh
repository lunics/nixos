#!/usr/bin/env bash

# needed to import $BROWSER, per-user profile as a nixos submodule, ~/.nix-profile standalone
for profile in /etc/profiles/per-user/${1} /home/${1}/.nix-profile; do
  [ -f "${profile}/etc/profile.d/hm-session-vars.sh" ] && source "${profile}/etc/profile.d/hm-session-vars.sh" && break
done

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
	# rsync -av --delete --exclude .unpacked $cache_path_ram/ $cache_path_disk/   # sync cache   ram -> disk
else
	rsync -av ./$static/ ./$link/                     # sync profile disk -> ram
	# rsync -av $cache_path_disk/ $cache_path_ram/      # sync cache   disk -> ram
	touch $link/.unpacked                             # create a flag to sync to ram only once
fi
