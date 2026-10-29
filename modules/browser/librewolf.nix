{
  flake.aspects.browser.homeManager = {
    _.persistent-home.dirs = [ ".librewolf" ];

    programs.librewolf = {
      enable  = false;
      settings = {
        "webgl.disabled" = false;
        "privacy.resistFingerprinting" = false;
      };
    };
  };
}
