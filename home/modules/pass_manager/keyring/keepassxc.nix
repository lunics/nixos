{ config, lib, pkgs, ... }:{
  config = lib.mkIf (config._.keyring == "keepassxc") {
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
}
