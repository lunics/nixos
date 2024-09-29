{ config, pkgs, lib, ... }:{
  nixpkgs.overlays =  [
    inputs.neovim-nightly-overlay.overlay
  ];
}
