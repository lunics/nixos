{
  flake.modules.nixos.disko = {
    disko.devices.disk.nvme0n1.content.partitions.boot = {
      label = "BOOT";
      name  = "ESP";
      size  = "1G";
      type  = "EF00";
      content = {
        type         = "filesystem";
        format       = "vfat";
        mountpoint   = "/boot";
        mountOptions = [ "defaults" ]; 
      }; 
    };
  };
}
