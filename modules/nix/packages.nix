{ pkgs, ... }:{ 
  home.packages = with pkgs; [
    deploy-rs
    # nix-init          # generate Nix packages from URLs
    # comma             # to runs nix software without installing it
  ];

  nixpkgs = {
    config = {
      allowUnfree = true;
      # allowBroken = true;
    };
    # overlays = null;
  };
}
