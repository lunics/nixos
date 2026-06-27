{
  flake.aspects.pass_manager = { aspects, ... }:{
    includes = with aspects; [ age ];

    homeManager = { config, lib, ... }:{
      config = lib.mkIf config._.pass_manager == "gopass" {
        # sessionVariables.PASSWORD_STORE_DIR = "${config._.share}/gopass";   # for rofi-pass
      };
    };
  };
}
