{ config, inputs, pkgs, ... }:{

  imports = [
    ./firefox
    ./librewolf.nix
    ./chromium.nix
    ./zen.nix
    ./psd.nix
    ./sync_browser_profile.nix
  ];

  home.sessionVariables.BROWSER = "${config._.browser}";

  _.add_to_startup = [ config._.browser ];
}
