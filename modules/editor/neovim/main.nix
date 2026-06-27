{ inputs, ... }:{
  flake-file.inputs.nixvim = {
    url = "github:nix-community/nixvim";
  };

  flake.aspects.neovim.homeManager = { config, pkgs, ... }:{
    imports = [ inputs.nixvim.homeModules.nixvim ];

    programs.nixvim = {
      enable = true;

      _module.args._config = config;    # config already used by nixvim
      _module.args._pkgs = pkgs;

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
