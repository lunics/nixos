{ config, lib, pkgs, ... }:{
  programs.firefox = {
    enable        = config._.browser == "firefox";
    package       = (pkgs.wrapFirefox (pkgs.firefox-unwrapped.override { pipewireSupport = true;}) {}); # Screen Sharing under Wayland
    configPath    = config._.firefox.path;
    languagePacks = [ "fr" "en-US" ];
  };

  home.activation.firefox_cache = lib.hm.dag.entryAfter ["writeBoundary"] ''
    link_cache=${config._.dot_cache}/mozilla/firefox/${config._.user}

    if [ ! -L $link_cache ]; then
      ln -s ${config._.share}/browser/firefox/${config._.user}_cache $link_cache
    fi
  '';

  ## break the symlink of profiles.ini
  # home.activation.fix_firefox_profiles = lib.hm.dag.entryAfter ["writeBoundary"] ''
  #   sed -i 's/IsRelative=1/IsRelative=0/' ${config._.firefox.path}/profiles.ini
  # '';
}
