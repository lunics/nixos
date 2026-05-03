{ pkgs, ... }:{
  imports = [
    ./service.nix
    ./script.nix
  ];

  _.add_to_startup = [ "awww-daemon" ];
}
