{ config, pkgs, inputs, ...}: {

  imports = [
    inputs.ags.homeManagerModules.default
    ./packages
    ./shell
    ./ssh_client.nix
    ./git.nix
    ./terminal.nix
    ./launcher.nix
    ./notifier.nix
    ./window_manager.nix
    ./file_explorer.nix
    ./multiplexer.nix
    ./browser
    ./gpg.nix
    ./pass_manager.nix
    # ./status_bar.nix
  ];

  programs.home-manager.enable = true;

  home = {
    username      = "lunics";
    homeDirectory = "/home/lunics";
    stateVersion  = "24.05";

    # KO
    # file = {
    #   ".zshrc".source = "~/.config/shell/zsh/.zshrc";
    #   # ".config/tmux".source = ~/dotfiles/tmux;
    #   # ".tmux.conf".text = ''
    #   #   set -g prefix ^A
    #   # '';
    # };
  };
}
