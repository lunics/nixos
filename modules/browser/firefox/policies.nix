{ 
  programs.firefox.policies = {
    AppAutoUpdate = false;
    DisablePocket = true;
    DisableTelemetry = true;
    OverrideFirstRunPage = "";
    OverridePostUpdatePage = "";
    DisableProfileImport = true; # Purity enforcement: Only allow nix-defined profiles
    DisableProfileRefresh = true; # Disable the Refresh Firefox button on about:support and support.mozilla.org
    DisableSetDesktopBackground = true; # Remove the “Set As Desktop Background…” menuitem when right clicking on an image, because Nix is the only thing that can manage the backgroud
    
    EnableTrackingProtection = {
      Value= true;
      Locked = true;
      Cryptomining = true;
      Fingerprinting = true;
      EmailTracking = true;
    };
    
    FirefoxHome = {
      "Search" = true;
      "TopSites" = true;
      "SponsoredTopSites" = false;
      "Highlights" = false;
      "Pocket" = false;
      "SponsoredPocket" = false;
      #"Snippets" = true | false,
      #"Locked" = true | false
    };
    
    FirefoxSuggest = {
      "WebSuggestions" = true;
      "SponsoredSuggestions" = false;
      "ImproveSuggest" = true;
      #"Locked" = true | false
    };
  };
}
