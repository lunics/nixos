{
  flake.aspects.pass_manager.homeManager = { config, lib, pkgs, ... }:{
    config = lib.mkIf (config._.keyring == "keepassxc") {
      _.persistent-home.dirs = [ ".cache/keepassxc" ];    # last opened databases, the settings are managed here

      programs.keepassxc = {
        autostart = true;
        enable    = true;
        settings  = {
          # more settings: https://github.com/keepassxreboot/keepassxc/blob/develop/src/core/Config.cpp
          FdoSecrets.Enabled = true;    # enable secret service integration
        };
      };

      xdg.autostart.enable = lib.mkForce true; # Enable creation of XDG autostart entries.
    };
  };
}
