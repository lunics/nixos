{
  flake.aspects.nix.homeManager = { pkgs, ... }:{
    home.packages = with pkgs; [
      deploy-rs
      nixos-anywhere
      # nix-init          # generate Nix packages from URLs
      # comma             # to runs nix software without installing it
    ];

    nixpkgs = {
      config = {
        allowUnfree = false;
        allowBroken = false;
      };
      # overlays = null;
    };
  };
}
