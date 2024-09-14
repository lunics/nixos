{ config, pkgs, inputs, ...}: {

  imports = [
    inputs.ags.homeManagerModules.default
    ./packages
    ./shell
    ./ssh_client.nix
    ./git.nix
    ./terminal.nix
    # ./launcher.nix
    ./notifier.nix
    # ./pass_manager.nix
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

  # home.file = {
  #   ".zshrc".source = ~/dotfiles/zshrc/.zshrc;
  #   ".config/tmux".source = ~/dotfiles/tmux;
  #   ".tmux.conf".text = ''
  #     set -g prefix ^A
  #   '';
  # };

}
