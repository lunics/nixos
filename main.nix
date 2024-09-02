{ config, pkgs, lib, inputs, ...}: {

  imports = [
    # ./aliases.nix
    inputs.ags.homeManagerModules.default
  ];

  programs = {
    home-manager.enable = true;

    ags = {
      enable = true;

      # additional packages to add to gjs's runtime
      extraPackages = with pkgs; [
        gtksourceview
        webkitgtk
        accountsservice
      ];
    };

    direnv.enable = true;
    direnv.enableBashIntegration = true;
    direnv.nix-direnv.enable = true;

    # gpg.enable = true;
    # gpg.homedir = "${config.home.homeDirectory}/.config/gnupg";

  };

  home = {
    username      = "lunics";
    homeDirectory = "/home/lunics";
    stateVersion  = "24.05";
  };
}
