{
  flake.modules.nixos.disko = { config, lib, ... }: let
    _ = config._.disk;
  in {
    config = lib.mkIf _.luks {
      disko.devices.disk.${_.device}.content.partitions = {
        luks = {
          size    = "100%";
          label   = "LUKS";
          content = {
            type  = "luks";
            name  = "luks";
          };
        };
      };
    };
  };
}
