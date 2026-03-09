{ config, ... }:{
  programs.firefox.profiles.${config._.user}.settings = {
    "sidebar.verticalTabs"  = true;                   # enable vertical tabs
    "sidebar.visibility"    = "always-show";
    "sidebar.revamp"        = true;                   # to help keep sidebar expanded
    "sidebar.expandOnHover" = false;
    

    "browser.tabs.inTitlebar"                = 0;     # 0 = hide horizontal tab bar, 1 = show
    "browser.tabs.insertAfterCurrent"        = true;  # open tab next to the current
    "browser.tabs.insertRelatedAfterCurrent" = true;  
    "browser.tabs.tabMinWidth"               = 5;
    "browser.tabs.drawInTitlebar"            = false; # use os window border

    "browser.link.open_newwindow"                   = 3; # open links from external apps in: 1=current tab, 2=new window, 3=new tab
    "browser.link.open_newwindow.restriction"       = 0;
    "browser.link.open_newwindow.override.external" = 7; # open links from apps next to your active tab

    "browser.fullscreen.autohide"             = false;
    "browser.quitShortcut.disabled"           = true;
    "browser.startup.page"                    = 3;        # resume previous session on startup
    "browser.uidensity"                       = 1;        # 1 = Density compact
    "browser.ctrlTab.recentlyUsedOrder"       = false;    # disable thumbnail preview ctrl + tab
    "browser.translations.enable"             = false;
    "browser.translations.automaticallyPopup" = false;
    
    "widget.gtk.non-native-titlebar-buttons.enabled" = false;   # use native GTK buttons
    "widget.non-native-theme.scrollbar.size"         = 24;      # custom scrollbar
    "widget.use-xdg-desktop-portal.file-picker"      = 1;

    "ui.context_menus.after_mouseup" = true;        # fix right click

    # "extensions.pocket.enabled" = false;
    
    # "toolkit.legacyUserProfileCustomizations.stylesheets" = true;   # Allow customChrome.css
    
    # "general.smoothScroll" = false;
    
    
    # # Enable video hardware acceleration
    # "media.ffmpeg.vaapi.enabled"   = true;
    # "media.ffvpx.enabled"          = false;
    # "media.peerconnection.enabled" = false;     # WebRTC leak prevention
    # "gfx.webrender.all"            = true;
    # "webgl.disabled"               = true;

    # "geo.enabled" = false;
    # "privacy.resistFingerprinting" = true;
    # "privacy.resistFingerprinting.autoDeclineNoUserInputCanvasPrompts" = true;
    # "privacy.firstparty.isolate" = true;
    # "network.http.referer.XOriginPolicy" = 2;
    # "network.http.referer.XOriginTrimmingPolicy" = 2;
    # "network.prefetch-next" = false;
    # "network.dns.disablePrefetch" = true;
    # "network.predictor.enabled" = false;
    # "network.http.speculative-parallel-limit" = 0;

    # "security.OCSP.require" = true;
    # "toolkit.telemetry.enabled" = false;
    # "datareporting.healthreport.uploadEnabled" = false;
    # "browser.ping-centre.telemetry" = false;
    
    # https://wiki.archlinux.org/index.php/Firefox/Tweaks#Performance
    # "browser.preferences.defaultPerformanceSettings.enabled" = false;
    # "dom.ipc.processCount" = 8;
    
    # Workaround for when xdg.portal is enabled? set to false
    # https://bugzilla.mozilla.org/show_bug.cgi?id=1618094
    # "network.protocol-handler.external-default" = false;
  };
}
