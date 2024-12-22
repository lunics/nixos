{ programs.firefox.profiles.Lunics.settings = {

"browser.fullscreen.autohide"   = false;
"browser.quitShortcut.disabled" = true;
"browser.tabs.tabMinWidth"      = 5;
"browser.startup.page"          = 3;            # Resume previous session on startup
"browser.uidensity"             = 1;            # 1 = Density compact
"browser.tabs.drawInTitlebar"   = false;        # Use OS window border
"browser.tabs.inTitlebar"       = 1;            # Use OS window border
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

};}
