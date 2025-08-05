{ pkgs, ... }:{
  programs.firefox = {
    enable        = false;
    package       = (pkgs.wrapFirefox (pkgs.firefox-unwrapped.override { pipewireSupport = true;}) {}); # Screen Sharing under Wayland
    configPath    = ".mozilla/firefox";   # can be modified for ex to: path/share/firefox
    languagePacks = [ "fr" "en-US" ];

    ## Sync folder to copy data's extensions
    # get UUID: about:debugging#/runtime/this-firefox
    # ~/.mozilla/firefox/PROFILE-NAME/storage/default/moz-extension+++UUID
  };
}
