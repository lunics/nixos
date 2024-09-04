{ config, pkgs, lib, inputs, ...}: {

  imports = [
    ./zsh.nix
    ./programs/ssh.nix
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
    packages      = with pkgs; [
      neovim
      git
      gh
      lazygit
      alacritty
      tmux
      yazi
      ueberzugpp

      firefox
      tor-browser

      lsd
      fzf
      starship
      zoxide
      bat
      wget
      fd

      # unzip
      ouch
      xarchiver
    ];
  };
}
