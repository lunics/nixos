{ config, pkgs, ... }:{
  programs.firefox = {
    enable        = if config._.browser == "firefox" then true else false;
    package       = (pkgs.wrapFirefox (pkgs.firefox-unwrapped.override { pipewireSupport = true;}) {}); # Screen Sharing under Wayland
    configPath    = ".mozilla/firefox";   # can be modified for ex to: path/share/firefox
    languagePacks = [ "fr" "en-US" ];
  };
}
