{
  flake.aspects.packages.homeManager = { pkgs, ... }:{ 
    home.packages = with pkgs; [
      bottom
      pciutils      # for lspci
      usbutils      # for lsusb
      dysk          # information on the mounted disks
      duf           # df replacement
      dust          # du -sh replacement
    ];
  };
}
