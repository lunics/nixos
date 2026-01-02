{ inputs, ... }:{
  imports = [
    inputs.disko.nixosModules.disko
    ./device.nix
    ./boot.nix
    ./luks.nix
    ./btrfs.nix
    # ./disko.nix
    ./filesystem.nix
  ];
}
