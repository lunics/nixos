{ inputs, pkgs, ... }:{
  nixpkgs.overlays =  [
    inputs.neovim-nightly-overlay.overlay
  ];
}
