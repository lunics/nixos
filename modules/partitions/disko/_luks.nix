{
  flake.modules.nixos.disko = {
    disko.devices.disk.nvme0n1.content.partitions = {
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
}
