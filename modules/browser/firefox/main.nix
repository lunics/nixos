{
  flake.aspects.browser.homeManager = { config, lib, pkgs, ... }:{
    programs.firefox = {
      enable        = config._.browser == "firefox";
      package       = (pkgs.wrapFirefox (pkgs.firefox-unwrapped.override { pipewireSupport = true;}) {}); # Screen Sharing under Wayland
      configPath    = config._.firefox.path;
      languagePacks = [ "fr" "en-US" ];
    };

    home.activation.firefox-cache = lib.hm.dag.entryAfter ["writeBoundary"] ''
      link_cache=${config._.dot_cache}/mozilla/firefox/${config._.user}
      dest_cache=${config._.share}/browser/firefox/${config._.user}_cache

      if [ -e $(dirname $link_cache) ] && [ -e $(dirname $dest_cache) ] && [ ! -L $link_cache ]; then
        ln -s $dest_cache $link_cache
      fi

      if [ ! -L ${config._.firefox.path}/${config._.user} ]; then
        ln -s ${config._.share}/browser/firefox/ ${config._.firefox.path}/${config._.user}
      fi
    '';

    ## break the symlink of profiles.ini
    # home.activation.fix_firefox_profiles = lib.hm.dag.entryAfter ["writeBoundary"] ''
    #   sed -i 's/IsRelative=1/IsRelative=0/' ${config._.firefox.path}/profiles.ini
    # '';
  };
}
