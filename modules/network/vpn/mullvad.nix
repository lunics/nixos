{
  flake.aspects.mullvad = {
    nixos = { config, lib, pkgs, ... }: with lib; {
      services.mullvad-vpn = {
        enable     = true;
        package    = pkgs.mullvad;
        gui.enable = true;
        enableExcludeWrapper = true;    # activates the wrapper that allows the use of mullvad-exclude
      };

      _.persistent.dirs = mkIf config._.impermanence [
        "/var/cache/mullvad-vpn"
      ];
    };

    homeManager = { pkgs, ... }:{
      programs.mullvad-vpn = {
        enable  = true;
        package = pkgs.mullvad-vpn;
        settings = {
          preferredLocale              = "system";
          autoConnect                  = false;   # stay disconnected, the tunnel is started by hand
          enableSystemNotifications    = false;
          monochromaticIcon            = false;
          startMinimized               = true;    # only show up in the systray
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
  };
}
