{ pkgs, ... }:{

  imports = [
    ./firefox
    ./librewolf.nix
  ];

  home.packages = with pkgs; [
    google-chrome
  ];
}
