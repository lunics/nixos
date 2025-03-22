{ pkgs, ... }:{

programs.firefox = {
  enable     = true;
  package    = (pkgs.wrapFirefox (pkgs.firefox-unwrapped.override { pipewireSupport = true;}) {}); # Screen Sharing under Wayland
  vendorPath = "usb_copy/homelab/share/.mozilla";
  configPath = "usb_copy/homelab/share/.mozilla/firefox";
  languagePacks = [ "fr" "en-US" ];

  # ! Warn ! modifying profiles remove all datas: current tabs, history, plugins...
  profiles = {
    Lunics = {
      id        = 0;
      name      = "Lunics";
      isDefault = true;
      path      = "Lunics";     # = /home/lunics/.mozilla/firefox/Lunics
      # preConfig = TODO;         # extra preferences to be added to 'user.js' before .settings
      extraConfig = ''
        browser.bookmarks.file = ./bookmarks.html;
        browser.places.importBookmarksHTML = true;
      '';
      #userChrome = "";
      #userContent = ''
      #  /* Hide scrollbar in FF Quantum */
      #  *{scrollbar-width:none !important}
      #'';
    };
  };

  ## Sync folder to copy data's extensions
  # get UUID: about:debugging#/runtime/this-firefox
  # ~/.mozilla/firefox/Lunics/storage/default/moz-extension+++UUID

};

}
