{
  flake.aspects.persistent.nixos = { config, lib, pkgs, ... }: with lib;
  let
    _     = config._;
    btrfs = "${pkgs.btrfs-progs}/bin/btrfs";
    users = filter (user: user.isNormalUser) (attrValues config.users.users);
    paths = [ _.persistent-system.dest ] ++ map (user: "${_.persistent-home.dest}${user.home}") users;
  in {
    # runs on every switch and boot, before the preservation mounts, so a new user needs no manual step
    system.activationScripts.persistent-subvolumes.text = ''
      for path in ${concatStringsSep " " paths}; do
        if [ ! -e $path ]; then
          mkdir -p $(dirname $path)
          ${btrfs} subvolume create $path
        elif ! ${btrfs} subvolume show $path > /dev/null 2>&1; then
          echo "persistent-subvolumes: $path is a plain directory, not a subvolume" >&2
        fi
      done
    '';
  };
}
