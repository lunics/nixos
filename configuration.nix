{ config, pkgs, lib, ... }:{

  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    substituters          = [ "https://hyprland.cachix.org" ];
    trusted-public-keys   = [ "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" ]; };

  nixpkgs.config.allowUnfree = true;

  # nixpkgs.overlays =  [ inputs.neovim-nightly-overlay.overlay ];

  # used in bash and zsh modules to add shell completion for packages that provide it.
  environment.pathsToLink = [ "/share/zsh" ];
  programs.zsh.enable = true;

  services.udisks2.enable = true;

  environment.systemPackages = with pkgs; [
    cachix
    # aquamarine
    # libsForQt5.polkit-kde-agent
  ];

  programs.fuse = {
    userAllowOther = true;
    mountMax       = 1000;
  };

  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  system.stateVersion = "24.05";
}
