{ pkgs, inputs, ... }:{

programs.firefox = {
  enable  = true;
  package = pkgs.firefox;
  languagePacks = [ "fr" "en-US" ];

  profiles = {
    lunics = {
      id        = 0;
      name      = "Lunics";
      isDefault = true;

      # todo line 518 /h/l/d/r/nixos/official/nur-expressions/pkgs/firefox-addons/addons.json
      extensions = with inputs.firefox-addons.packages.${pkgs.system}; [
        ublock-origin
        profile-switcher
        localcdn
        behave
        skip-redirect
        consent-o-matic
        # simple-tab-groups   # session manager alternative
        istilldontcareaboutcookies
        i-dont-care-about-cookies
        ipvfoo

        multi-account-containers
        temporary-containers
        tab-session-manager
        auto-tab-discard
        # open-url-in-container

        vimium
        gesturefy
        ghosttext
        hover-zoom-plus
        simple-translate
        # immersive-translate

        # gitako-github-file-tree

        tabliss
        # momentumdash

        h264ify
        videospeed
        # jump-cutter
        return-youtube-dislikes
        # musescore-downloader

        pipewire-screenaudio    # to connect webcall to pipewire

        browserpass
        passff

        lovely-forks
        refined-github

        # keepa   amazon price traker
        # darkreader
        # omnivore

        # tokyo-night-v2
        # theme-nord-polar-night
        # gruvbox-dark-theme
        # gnome-shell-integration

        # ipfs-companion
        # simplelogin     # self-hostable email alias protection
        # pushbullet
        # joplin-web-clipper
        # authenticator
        # open tabs next to current
        # wallabagger
        # Bukubrow
        # single-file
        # hoppscotch        request API builder
      ];

      settings = {
        "browser.fullscreen.autohide"   = false;
        "browser.quitShortcut.disabled" = true;
        "browser.tabs.tabMinWidth"      = 5;
        "browser.startup.page"          = 3;
        "browser.uidensity"             = 1;        # 1 = Density compact
        "browser.tabs.drawInTitlebar"   = false;    # Use OS window border
        "browser.tabs.inTitlebar"       = 1;        # Use OS window border
        "browser.ctrlTab.recentlyUsedOrder" = false;    # Disable thumbnail preview ctrl + tab
        "browser.translations.enable"   = false;
        "browser.translations.automaticallyPopup" = false;

        "widget.gtk.non-native-titlebar-buttons.enabled" = false;          # use native GTK buttons
        "widget.non-native-theme.scrollbar.size" = 24;         # custom scrollbar
        "widget.use-xdg-desktop-portal.file-picker" = 1;

        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;   # Allow customChrome.css

        "extensions.pocket.enabled" = false;
        "general.smoothScroll" = false;

        "ui.context_menus.after_mouseup" = true;        # Fix right click

        # Enable video hardware acceleration
        "media.ffmpeg.vaapi.enabled"  = true;
        "gfx.webrender.all"           = true;
        "media.ffvpx.enabled"         = false;

        # https://wiki.archlinux.org/index.php/Firefox/Tweaks#Performance
        # "browser.preferences.defaultPerformanceSettings.enabled" = false;
        # "dom.ipc.processCount" = 8;

        # Workaround for when xdg.portal is enabled? set to false
        # https://bugzilla.mozilla.org/show_bug.cgi?id=1618094
        # "network.protocol-handler.external-default" = false;
      };
    };
  };
};
}
