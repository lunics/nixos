{ config, pkgs, lib, ... }:

let
  dir = ./modules; # directory containing the modules
  allFiles = builtins.attrNames (builtins.readDir dir);
  allModules = map (filename: import "${dir}/${filename}") allFiles;
in
{
  imports = allModules;
}
