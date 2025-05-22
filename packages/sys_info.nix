{ pkgs, ... }:{ 
  home.packages = with pkgs; [
    bottom
    pciutils      # for lspci
    usbutils      # for lsusb
    zmkBATx       # battery monitoring for ZMK split keyboards
    dysk          # information on the mounted disks
    duf           # df replacement
    dust          # du -sh replacement
  ];
}
