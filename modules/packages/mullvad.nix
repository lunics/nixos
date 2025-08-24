{
  programs.mullvad-vpn = {
    enable  = true;
    package = pkgs.mullvad-vpn;
    settings = {
      preferredLocale              = "system";
      autoConnect                  = false;
      enableSystemNotifications    = true;
      monochromaticIcon            = false;
      startMinimized               = false;
      unpinnedWindow               = true;
      updateDismissedForVersion    = "";
      animateMap                   = true;
      changelogDisplayedForVersion = "";
      browsedForSplitTunnelingApplications = [];
    };
  };
}
