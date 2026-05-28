{
  flake.aspects.disk.nixos = { config, lib, ... }: let
    _ = config._.disk;
  in {
    config = lib.mkIf _.luks {
      disko.devices.disk.${_.device}.content.partitions = {
        luks = {
          size  = "100%";
          label = "LUKS";
          uuid  = _.luks_partuuid;
            ## use uuid instead of label if errors
            ## label can't be used in dual boot ?
            ## maybe the error comes from boot.initrd.luk.devices."luks".device
          content = {
            type = "luks";
            name = "luks";
          };
        };
      };
    };
  };
}
