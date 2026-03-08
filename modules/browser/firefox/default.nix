{ config, lib, pkgs, ... }:{
  config = lib.mkIf (config._.browser == "firefox") {
    programs.firefox = {
      enable        = false;
      package       = (pkgs.wrapFirefox (pkgs.firefox-unwrapped.override { pipewireSupport = true;}) {}); # Screen Sharing under Wayland
      configPath    = ".mozilla/firefox";   # can be modified for ex to: path/share/firefox
      languagePacks = [ "fr" "en-US" ];

      imports = [
        ./profiles.nix
        # ./policies.nix
        # ./extensions.nix
        # ./extensions_settings.nix
        # ./settings.nix
        # ./search.nix
        # ./bookmarks.nix
        # ./containers.nix
      ];

      ## Sync folder to copy data's extensions
      # get UUID: about:debugging#/runtime/this-firefox
      # ~/.mozilla/firefox/PROFILE-NAME/storage/default/moz-extension+++UUID
    };
  };
}
