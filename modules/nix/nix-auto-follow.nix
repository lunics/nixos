{ inputs, ... }:{
  flake-file.inputs = {
    nix-auto-follow = {
      url = "github:fzakaria/nix-auto-follow";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  flake.aspects.nix.homeManager = { pkgs, ... }:{
    home.packages = [
      inputs.nix-auto-follow.packages.${pkgs.stdenv.hostPlatform.system}.default
    ];

    # nixos-raspberrypi pins nvmd forks (nixos-images#sdimage-installer), determinate pins its own nixpkgs: rewriting it changes the nix drv
    home.shellAliases.auto-follow = "auto-follow --ignore nixos-raspberrypi --ignore determinate";
  };
}
