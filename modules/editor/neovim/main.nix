{ inputs, ... }:{
  flake-file.inputs.nixvim = {
    url = "github:nix-community/nixvim";
  };

  flake.aspects.neovim.homeManager = { config, pkgs, ... }:{
    imports = [ inputs.nixvim.homeModules.nixvim ];

    programs.nixvim = {
      enable = true;

      _module.args._options = config._;  # only the `_` namespace: passing the
                                          # whole `config` makes nixvim's nixpkgs
                                          # module force the host config -> inf rec
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
