{
  flake.aspects.auto-upgrade.nixos = { config, ... }:{
    # required by system.autoUpgrade when the config is a flake owned by a user
    programs.git = {
      enable = true;
      config.safe.directory = [ config._.flake_dir ];
    };
  };
}
