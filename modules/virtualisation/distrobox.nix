{
  flake.aspects.distrobox.homeManager = { config, ... }:{
    _.persistent-home.dirs = [ ".local/share/containers" ];    # rootless podman storage of the boxes

    programs.distrobox = {
      enable     = true;
      enableSystemdUnit = config.programs.distrobox.containers != {} && config.programs.distrobox.package != null;
      settings   = {};
      containers = {};
    };
  };
}
