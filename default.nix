{ config, pkgs, inputs, ...}: {

  imports = [
    inputs.ags.homeManagerModules.default
    # inputs.nur.hmModules.nur
    ./packages
    ./shell
    ./ssh_client.nix
    ./git.nix
    ./desktop
    ./terminal.nix
    ./file_explorer.nix
    ./multiplexer.nix
    ./browser
    ./gpg.nix
    ./pass_manager.nix
  ];

  programs.home-manager.enable = true;

  home = {
    username      = "***REMOVED***";
    homeDirectory = "/home/***REMOVED***";
    stateVersion  = "24.05"; };
}
