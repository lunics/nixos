{
  flake.aspects.virtualisation.nixos = { config, lib, ... }:{
    config = lib.mkIf config._.microvm.enable {
      microvm = {
        vms      = config._.microvm.vms;
        stateDir = "/var/lib/microvms";

        host = {
          enable           = true;
          startupTimeout   = 150;
          useNotifySockets = false;
        };

        autostart = [];
      };
    };
  };
}
