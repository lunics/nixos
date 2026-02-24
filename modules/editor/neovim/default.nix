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
}
