{ config, pkgs, lib, ... }:{

  nix.settings = {
    trusted-users         = [ "root" "***REMOVED***" ];   # required for deploy-rs
    experimental-features = [ "nix-command" "flakes" ];
    substituters          = [ "https://hyprland.cachix.org" ];
    trusted-public-keys   = [ "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" ]; };

  nixpkgs.config.allowUnfree = true;

  # used in bash and zsh modules to add shell completion for packages that provide it.
  environment.pathsToLink = [ "/share/zsh" ];
  programs.zsh.enable = true;

  environment.systemPackages = with pkgs; [
    cachix        # fetch cache after cachix install with: nix flake update
    distrobox
  ];

  programs.fuse = {
    userAllowOther = true;
    mountMax       = 1000;    # default=1000
  };

  system.stateVersion = "24.05";
}
