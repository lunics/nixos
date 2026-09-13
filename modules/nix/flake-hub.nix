{ inputs, ... }:{
  flake-file.inputs = {
    # no nixpkgs.follows here: Determinate Nix would then be rebuilt from source instead of hitting its cache
    determinate.url = "https://flakehub.com/f/DeterminateSystems/determinate/*";
  };

  flake.aspects.flake-hub = {
    nixos = {
      imports = [ inputs.determinate.nixosModules.default ];

      determinate.enable = true;    # swaps nix-daemon for determinate-nixd, FlakeHub auth included
    };

    homeManager = {
      # guarded: the aspect can be included home-side on a host without Determinate
      programs.zsh.initContent = ''
        command -v determinate-nixd >/dev/null && eval "$(determinate-nixd completion zsh)"
      '';
    };
  };
}
