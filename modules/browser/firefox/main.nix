{ config, lib, pkgs, ... }:{
  programs.firefox = {
    enable        = config._.browser == "firefox";
    package       = (pkgs.wrapFirefox (pkgs.firefox-unwrapped.override { pipewireSupport = true;}) {}); # Screen Sharing under Wayland
    configPath    = config._.firefox_path;
    languagePacks = [ "fr" "en-US" ];
  };

  ## break the symlink of profiles.ini
  # home.activation.fix_firefox_profiles = lib.hm.dag.entryAfter ["writeBoundary"] ''
  #   sed -i 's/IsRelative=1/IsRelative=0/' ${config._.firefox_path}/profiles.ini
  # '';
}
