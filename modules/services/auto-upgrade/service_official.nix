{ config, ... }: {
  services.home-manager.autoUpgrade = {
    enable    = true;
    frequency = "Fri *-*-* 21:00:00";
    useFlake  = true;
    flakeDir  = "/home/lunics/usb_copy/homelab/nixos/inventory";
  };
}
