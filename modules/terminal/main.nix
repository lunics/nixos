{
  flake.aspects.options.vars = { lib, ... }: with lib; {
    options._.terminal = mkOption {
      type    = types.str;
      default = "ghostty";
    };
  };

  flake.aspects.terminal.homeManager = { config, pkgs, ... }:{
    home.sessionVariables.TERMINAL = "${config._.terminal}";

    _.add_to_startup = [ config._.terminal ];
  };
}
