{ 
  programs.firefox.policies = {
    DisablePocket               = true;
    DisableTelemetry            = true;
    DisableProfileImport        = true;   # purity enforcement: Only allow nix-defined profiles
    DisableProfileRefresh       = true;   # disable the Refresh Firefox button on about:support and support.mozilla.org
    DisableSetDesktopBackground = true;   # remove the “Set As Desktop Background…” menuitem when right clicking on an image, because Nix is the only thing that can manage the backgroud
    DisableFeedbackCommands     = true;
    DisableFirefoxAccounts      = true;
    DisableFirefoxStudies       = true;
    DisableFormHistory          = true;      ## maybe to disable

    AppAutoUpdate               = false;
    NoDefaultBookmarks          = true;
    PasswordManagerEnabled      = false;
    OfferToSaveLogins           = false;
    HttpsOnlyMode               = "force_enabled";
    SSLVersionMin               = "tls1.2";
    OverrideFirstRunPage        = "";
    OverridePostUpdatePage      = "";

    DNSOverHTTPS = {
      Enabled     = true;
      ProviderURL = "https://dns.quad9.net/dns-query";
      Locked      = false;
    };
    
    EnableTrackingProtection = {
      Value          = true;
      Locked         = true;
      Cryptomining   = true;
      Fingerprinting = true;
      EmailTracking  = true;
    };
    
    FirefoxHome = {
      "Search"            = true;
      "TopSites"          = true;
      "SponsoredTopSites" = false;
      "Highlights"        = false;
      "Pocket"            = false;
      "SponsoredPocket"   = false;
      #"Snippets" = true | false,
      #"Locked" = true | false
    };
    
    SearchSuggestEnabled = true;      # false to disable all
    FirefoxSuggest = {
      "WebSuggestions"       = true;
      "ImproveSuggest"       = true;
      "SponsoredSuggestions" = false;
      #"Locked" = true | false
    };

    UserMessaging = {
      SkipOnboarding           = true;
      WhatsNew                 = false;
      ExtensionRecommendations = false;
      FeatureRecommendations   = false;
      MoreFromMozilla          = false;
      FirefoxLabs              = false;
    };
  };
}
