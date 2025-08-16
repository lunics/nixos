{ pkgs, inputs, ... }:{

  imports = [
    ./firefox
    ./librewolf.nix
    ./chromium.nix
    ./zen.nix
    ./psd.nix
  ];
}
