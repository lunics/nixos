{ config, pkgs, lib, ... }:{
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    cachix        # fetch cache after cachix install with: nix flake update
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
