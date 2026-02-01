{ config, pkgs, ... }: {
  imports = [ 
    ./script-flake-update.nix
    ./script-git-commit.nix 
    ./service.nix 
  ];
}
