{ inputs, ... }:{
  flake-file.inputs.nixvim = {
    url = "github:nix-community/nixvim";
    inputs.nixpkgs.follows = "nixpkgs"; 
  };

  flake.aspects.neovim.homeManager = { config, ... }:{
    imports = [ inputs.nixvim.homeModules.nixvim ];

    programs.nixvim = {
      enable = true;

      _module.args._config = config;    # config already used by nixvim

      imports = [
       ./_opts.nix
       ./_plugins
       ./_autocmds
       ./_keymaps
       ./_colorschemes.nix
      ];
    };
  };
}
