{ config, pkgs, lib, ... }:{

  nix.settings = {
    trusted-users         = [ "root" "lunics" ];   # required for deploy-rs
    experimental-features = [ "nix-command" "flakes" ];
    substituters          = [ "https://hyprland.cachix.org" ];
    trusted-public-keys   = [ "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" ]; 
    auto-optimise-store   = true;     #  detects identical files in the store and replaces them with hard links
  };

  nixpkgs.config.allowUnfree = true;

  # used in bash and zsh modules to add shell completion for packages that provide it.
  environment.pathsToLink = [ "/share/zsh" ];
  programs.zsh.enable = true;

  environment.systemPackages = with pkgs; [
    cachix        # fetch cache after cachix install with: nix flake update
    distrobox
  ];

  programs = {
    fuse = {
      userAllowOther = true;
      mountMax       = 1000;    # default=1000
    };

    nh.enable = true;
  };

  system.stateVersion = "24.11";    # Not respected by the unstable branch
}
