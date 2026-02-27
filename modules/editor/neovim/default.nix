{ config, inputs, ... }:{
  imports = [ 
    inputs.nixvim.homeModules.nixvim
  ];

  programs.nixvim = {
    enable = true;

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
