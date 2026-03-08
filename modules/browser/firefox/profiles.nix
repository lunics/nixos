{ config, ... }:{
  programs.firefox.profiles.${config._.user} = {
    id         = 0;
    name       = config._.user;
    isDefault  = true;
    path       = "${config._.share}/browser/firefox/${config._.user}";   # default = ~/.mozilla/firefox/PROFILE_NAME
    preConfig  = "";      # extra preferences to be added to 'user.js' before .settings
    # extraConfig = ''
    #   browser.bookmarks.file = ./bookmarks.html;
    #   browser.places.importBookmarksHTML = true;
    # '';
    # userChrome = "";
    #userContent = ''
    #  /* Hide scrollbar in FF Quantum */
    #  *{scrollbar-width:none !important}
    #'';
  };
}
