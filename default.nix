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

    # direnv = {    # to auto read .envrc et .env everywhere
    #   enable = true;
    #   enableBashIntegration = true;
    #   nix-direnv.enable = true;       };
  };

  home = {
    username      = "lunics";
    homeDirectory = "/home/lunics";
    stateVersion  = "24.05";      };
}
