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
    ./services.nix
    ./k3s.nix
  ];

  programs.home-manager.enable = true;

  home = {
    username      = "lunics";
    homeDirectory = "/home/lunics";
    stateVersion  = "24.05"; };
}
