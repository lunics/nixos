{ config, inputs, ... }:{
  imports = [ 
    inputs.nixvim.homeModules.nixvim
  ];

  programs.nixvim = {
    _module.args._config = config;    # config already used by nixvim

    imports = [
     ./opts.nix
     ./plugins
     ./autocmds
     ./keymaps
     ./colorschemes.nix
    ];
  };

  # old
  # programs.nixvim = lib.mkMerge [
  #    (import ./opts.nix)
  #    (import ./plugins)
  #    (import ./autocmds)
  #    (import ./keymaps)
  # ];
}
