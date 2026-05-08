{ config, pkgs, ... }:{
  home.sessionVariables.TERMINAL = "${config._.terminal}";

  _.add_to_startup = [ config._.terminal ];
}
