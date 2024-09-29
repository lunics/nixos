{ inputs, pkgs, lib, config, ... }:{
  nixpkgs.overlays =  [
    inputs.neovim-nightly-overlay.overlay
  ];
}
