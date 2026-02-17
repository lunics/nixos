{ inputs, lib, ... }:{
  imports = [ 
    inputs.nixvim.homeModules.nixvim
    ./keymaps
  ];

  programs.nixvim = lib.mkMerge [
     (import ./opts.nix)
     (import ./plugins)
     (import ./autocmds)
  ];
}
