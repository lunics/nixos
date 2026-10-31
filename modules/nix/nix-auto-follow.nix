{ inputs, ... }:{
  flake-file.inputs = {
    nix-auto-follow = {
      url = "github:fzakaria/nix-auto-follow";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  flake.aspects.nix.homeManager = { pkgs, ... }:{
    home.packages = [
      (inputs.nix-auto-follow.packages.${pkgs.stdenv.hostPlatform.system}.default.overrideAttrs (old: {
        # structuredAttrs keeps upstream's top-level SETUPTOOLS_SCM_PRETEND_VERSION out of the env, and env can't redefine it
        env = (old.env or {}) // { SETUPTOOLS_SCM_PRETEND_VERSION_FOR_NIX_AUTO_FOLLOW = "0.0.0"; };
      }))
    ];

    # nixos-raspberrypi pins nvmd forks (nixos-images#sdimage-installer), determinate pins its own nixpkgs: rewriting it changes the nix drv
    home.shellAliases.auto-follow = "auto-follow --ignore nixos-raspberrypi --ignore determinate";
  };
}
