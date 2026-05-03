{ config, lib, ... }:{
  hardware.bluetooth = {
    enable      = true;
    powerOnBoot = true;
    settings = {
      General.Experimental = true; 
    };
  };

  services.blueman.enable = true;   # GTK+ bluetooth manager

  _.persistent.dirs = lib.mkIf config._.impermanence [ 
    "/var/lib/bluetooth" 
  ];
}
