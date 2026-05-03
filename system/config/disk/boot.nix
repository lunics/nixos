{ config, ... }:let 
  _ = config._.disk; 
in {
  config.disko.devices.disk.${_.device}.content.partitions = {
    boot = {
      label = "boot";
      name  = "ESP";
      size  = "${_.boot}";
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
