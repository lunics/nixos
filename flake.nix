{
  inputs = {
    stable.url   = "github:nixos/nixpkgs/nixos-24.11";
    unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "unstable"; 
    };
  };
  outputs = { self, nixos-hardware, disko, ... }:{
    nixosModules.system = import ./modules;
  };
}
