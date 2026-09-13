{ inputs, ... }:{
  flake-file.inputs = {
    # no nixpkgs.follows here: Determinate Nix would then be rebuilt from source instead of hitting its cache
    determinate.url = "https://flakehub.com/f/DeterminateSystems/determinate/*";
  };

  flake.aspects.nix.nixos = {
    imports = [ inputs.determinate.nixosModules.default ];

    determinate.enable = true;    # swaps nix-daemon for determinate-nixd, FlakeHub auth included
  };
}
