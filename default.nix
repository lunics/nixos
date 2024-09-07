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
    ./launcher.nix
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
  };

  home = {
    username      = "lunics";
    homeDirectory = "/home/lunics";
    stateVersion  = "24.05";      };
}
