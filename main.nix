{ config, pkgs, inputs, ...}: {

  imports = [
    inputs.ags.homeManagerModules.default
    ./packages.nix
    ./ssh_client.nix
    ./git.nix
    ./bash.nix
    ./aliases.nix
    ./env_var.nix
    ./terminal.nix
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

    direnv = {
      enable = true;
      enableBashIntegration = true;
      nix-direnv.enable = true;       };

    # gpg.enable = true;
    # gpg.homedir = "${config.home.homeDirectory}/.config/gnupg";

  };

  home = {
    username      = "lunics";
    homeDirectory = "/home/lunics";
    stateVersion  = "24.05";      };
}
