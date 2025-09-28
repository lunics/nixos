{ inputs, ... }:{
  imports = [ inputs.zen-browser.homeModules.beta ];    # beta, twilight, twilight-official

  programs.zen-browser = {
    enable = true;
    # nativeMessagingHosts = [ pkgs.firefoxpwa ];
    # policies = {
    #   AutofillAddressEnabled = true;
    #   AutofillCreditCardEnabled = false;
    #   DisableAppUpdate = true;
    #   DisableFeedbackCommands = true;
    #   DisableFirefoxStudies = true;
    #   DisablePocket = true;
    #   DisableTelemetry = true;
    #   DontCheckDefaultBrowser = true;
    #   NoDefaultBookmarks = true;
    #   OfferToSaveLogins = false;
    #   EnableTrackingProtection = {
    #     Value = true;
    #     Locked = true;
    #     Cryptomining = true;
    #     Fingerprinting = true;
    #   };
    # };
  };

  xdg = {
    mimeApps = {
      enable = true;
      defaultApplications = {
        "x-scheme-handler/http"         = "zen-beta.desktop";
        "x-scheme-handler/https"        = "zen-beta.desktop";
        "x-scheme-handler/chrome"       = "zen-beta.desktop";
        "text/html"                     = "zen-beta.desktop";
        "application/x-extension-htm"   = "zen-beta.desktop";
        "application/x-extension-html"  = "zen-beta.desktop";
        "application/x-extension-shtml" = "zen-beta.desktop";
        "application/xhtml+xml"         = "zen-beta.desktop";
        "application/x-extension-xhtml" = "zen-beta.desktop";
        "application/x-extension-xht"   = "zen-beta.desktop";
      };
      associations = {
        added = {     
          "x-scheme-handler/http"         = "zen-beta.desktop;zen-twilight.desktop";
          "x-scheme-handler/https"        = "zen-beta.desktop;zen-twilight.desktop";
          "x-scheme-handler/chrome"       = "zen-beta.desktop;zen-twilight.desktop";
          "text/html"                     = "zen-twilight.desktop;zen-beta.desktop";
          "application/x-extension-htm"   = "zen-twilight.desktop;zen-beta.desktop";
          "application/x-extension-html"  = "zen-twilight.desktop;zen-beta.desktop";
          "application/x-extension-shtml" = "zen-twilight.desktop;zen-beta.desktop";
          "application/xhtml+xml"         = "zen-twilight.desktop;zen-beta.desktop";
          "application/x-extension-xhtml" = "zen-twilight.desktop;zen-beta.desktop";
          "application/x-extension-xht"   = "zen-twilight.desktop;zen-beta.desktop";
        };
      };
    };
  };
}
