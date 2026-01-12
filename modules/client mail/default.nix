{ pkgs, ... }:{ 
  imports = [
    ./neomutt.nix
    ./proton-mail.nix
    ./thunderbird.nix
  ];
}

