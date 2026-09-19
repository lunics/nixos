{
  flake.aspects.raspberry-pi.nixos-raspberrypi = { config, lib, ... }:{
    # a rebuild over ssh restarts the link instead of stopping it, headless board
    systemd.services = lib.mkMerge [
      (lib.mkIf config.services.resolved.enable { 
        systemd-resolved.stopIfChanged = false; 
      })
      (lib.mkIf config.systemd.network.enable { 
        systemd-networkd.stopIfChanged = false; 
      })
      (lib.mkIf config.networking.networkmanager.enable { 
        NetworkManager.stopIfChanged = false; 
      })
    ];
  };
}
