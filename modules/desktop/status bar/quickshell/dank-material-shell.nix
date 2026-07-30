{ inputs, ... }:{
  flake-file.inputs.dank-material-shell = {
    url = "github:AvengeMedia/DankMaterialShell";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  flake.aspects.dank-material-shell.homeManager = { config, lib, pkgs, ... }:{
    imports = [ inputs.dank-material-shell.homeModules.dank-material-shell ];
  };
}
