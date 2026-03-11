{ pkgs, ... }:{ 
  home.packages = with pkgs; [
    bottom
    pciutils      # for lspci
    usbutils      # for lsusb
    zmkbatx       # battery level on sys tray for zmk splitkb
    dysk          # information on the mounted disks
    duf           # df replacement
    dust          # du -sh replacement
  ];
}
