{
  flake.aspects.browser.homeManager = { config, lib, ... }:{
    _.persistent-home.dirs = lib.mkIf config.programs.librewolf.enable [ ".librewolf" ];

    programs.librewolf = {
      enable  = false;
      settings = {
        "webgl.disabled" = false;
        "privacy.resistFingerprinting" = false;
      };
    };
  };
}
