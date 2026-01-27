{ config, pkgs, ... }: {
  imports = [ 
    ./service.nix 
    ./commit-git-flake.sh.nix 
    ./flake-update.sh.nix
  ];
}
