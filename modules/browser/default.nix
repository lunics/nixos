{ config, inputs, pkgs, ... }:{

  imports = [
    ./firefox
    ./librewolf.nix
    ./chromium.nix
    ./zen.nix
    ./psd.nix
  ];

  home.sessionVariables.BROWSER = "${config._.browser}";
}
