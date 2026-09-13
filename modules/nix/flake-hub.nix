{ inputs, ... }:{
  flake-file.inputs = {
    determinate.url = "https://flakehub.com/f/DeterminateSystems/determinate/*";
  };

  flake.aspects.flake-hub = {
    nixos = {
      imports = [ inputs.determinate.nixosModules.default ];

      determinate.enable = true;    # swaps nix-daemon for determinate-nixd
    };

    homeManager = {
      programs.zsh.initContent = ''
        command -v determinate-nixd >/dev/null && eval "$(determinate-nixd completion zsh)"
      '';
    };
  };
}
