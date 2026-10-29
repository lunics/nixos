{
  flake.aspects.browser.homeManager = { config, pkgs, ... }:{
    programs.firefox = {
      enable        = config._.browser == "firefox";
      package       = (pkgs.wrapFirefox (pkgs.firefox-unwrapped.override { withPipewire = true;}) {}); # Screen Sharing under Wayland
      configPath    = config._.firefox.path;
      languagePacks = [ "fr" "en-US" ];
    };

    _.persistent-home.dirs = [ ".config/mozilla/firefox" ];    # profiles, the cache stays ephemeral

    ## break the symlink of profiles.ini
    # home.activation.fix_firefox_profiles = lib.hm.dag.entryAfter ["writeBoundary"] ''
    #   sed -i 's/IsRelative=1/IsRelative=0/' ${config._.firefox.path}/profiles.ini
    # '';
  };
}
