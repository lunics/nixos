{ config, lib, inputs, ... }:{
  imports = [ inputs.zen-browser.homeModules.beta ];    # beta, twilight, twilight-official

  config = lib.mkIf (config._.browser == "zen") {
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

    home.file.".zen/profiles.ini"= {
      force = true;
      text = ''
        [Profile0]
        Name=${config._.user}
        IsRelative=0
        Path=${config._.share}/browser/zen/${config._.user}
        Default=1
        
        [General]
        StartWithLastProfile=1
        Version=2
      '';
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
          "application/pdf"               = "zen-beta.desktop";
        };
        associations = {
          added = {     
            "x-scheme-handler/http"         = "zen-twilight.desktop;zen-beta.desktop";
            "x-scheme-handler/https"        = "zen-twilight.desktop;zen-beta.desktop";
            "x-scheme-handler/chrome"       = "zen-twilight.desktop;zen-beta.desktop";
            "text/html"                     = "zen-twilight.desktop;zen-beta.desktop";
            "application/x-extension-htm"   = "zen-twilight.desktop;zen-beta.desktop";
            "application/x-extension-html"  = "zen-twilight.desktop;zen-beta.desktop";
            "application/x-extension-shtml" = "zen-twilight.desktop;zen-beta.desktop";
            "application/xhtml+xml"         = "zen-twilight.desktop;zen-beta.desktop";
            "application/x-extension-xhtml" = "zen-twilight.desktop;zen-beta.desktop";
            "application/x-extension-xht"   = "zen-twilight.desktop;zen-beta.desktop";
            "application/pdf"               = "zen-twilight.desktop;zen-beta.desktop";
          };
        };
      };
    };
  };
}
