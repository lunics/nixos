{ config, lib, pkgs, ... }:{
  config = lib.mkIf (config._.external_vpn == "mullvad") {
    programs.mullvad-vpn = {
      enable  = true;
      package = pkgs.mullvad-vpn;
      settings = {
        preferredLocale              = "system";
        autoConnect                  = true;
        enableSystemNotifications    = false;
        monochromaticIcon            = false;
        startMinimized               = true;
        unpinnedWindow               = true;
        updateDismissedForVersion    = "";
        animateMap                   = true;
        changelogDisplayedForVersion = "";
        browsedForSplitTunnelingApplications = [];
      };
    };

    home.packages = with pkgs; [
      mullvad-compass    # find Mullvad servers with the lowest latency at your location
    ];

    _.add_to_startup = [ "mullvad-vpn" ];
  };
}
