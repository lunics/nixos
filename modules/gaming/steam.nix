## Add steam general options cmd:
##   gamemoderun %command%
##   mangohud %command%
##   gamescope %command%
{ config, pkgs, ... }:{
  programs.steam = {
    enable  = config._.steam;
    package = pkgs.steam;
              # pkgs.steam.override {
      # extraEnv = {
        # MANGOHUD = true;
        # OBS_VKCAPTURE = true;
        # RADV_TEX_ANISO = 16;
      # };
      # extraLibraries = p: with p; [
        # atk
      # ];
    # }
    extraCompatPackages = with pkgs; [
      proton-ge-bin
    ];
    # extraPackages = with pkgs; [
    #   gamescope
    # ];

    fontPackages = with pkgs; [ source-han-sans ];

    gamescopeSession = {    # enable starting games in optimized compositor
      enable = true;
      # args = ;
      # env = ;
    };

    protontricks = {      # simple wrapper for running Winetricks commands for Proton-enable
      enable  = false;
      package = pkgs.protontricks;
    };

    remotePlay.openFirewall = false;                # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = false;           # Open ports in the firewall for Source Dedicated Server
    localNetworkGameTransfers.openFirewall = false; # Open ports in the firewall for Steam Local Network Game Transfers
  };
}
