{
  flake.aspects.distrobox.homeManager = { config, ... }:{
    programs.distrobox = {
      enable     = true;
      enableSystemdUnit = config.programs.distrobox.containers != {} && config.programs.distrobox.package != null;
      settings   = {};
      containers = {};
    };
  };
}
