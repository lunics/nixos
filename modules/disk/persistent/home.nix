{ config, ... }:
let
  flake = config.flake;
in {
  flake.aspects.persistent.nixos = { config, lib, ... }:
  let
    _ = config._;

    # integrated home-manager first, else the standalone configuration of this user on this host, read at eval time
    integrated = config ? home-manager && config.home-manager.users ? ${_.user};
    standalone = flake.homeConfigurations."${_.user}@${_.hostname}" or null;
    hm         = if integrated then config.home-manager.users.${_.user}._.persistent-home
                 else if standalone != null then standalone.config._.persistent-home
                 else { dirs = []; files = []; };
  in {
    # the home-manager aspects declare their paths, preservation bind mounts them
    preservation.preserveAt.${_.persistent-home.dest}.users.${_.user} = {
      directories = hm.dirs;
      files       = hm.files;
    };
  };
}
