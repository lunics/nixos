## Add steam general options cmd:
##   gamemoderun %command%
##   mangohud %command%
##   gamescope %command%
{
  flake.aspects.steam = {
    homeManager = { pkgs, ... }:{
      ## run prontonup to download latest Proton GE
      ##    Steam > Compatibility > Select latest GE-Proton9-4

      home.sessionVariables."STEAM_EXTRA_COMPAT_TOOLS_PATHS" = "\${HOME}/.steam/root/compatibilitytools.d";

      _.allow-unfree = with pkgs; [ 
        steamcmd 
        steam-unwrapped
      ];
    };
    nixos = { config, pkgs, ... }:{
      programs.steam = {
        enable  = config._.steam;
        package = pkgs.steam;
        #         pkgs.steam.override {
        #   extraEnv = {
        #     MANGOHUD = true;
        #     OBS_VKCAPTURE = true;
        #     RADV_TEX_ANISO = 16;
        #   };
        #   extraLibraries = p: with p; [
        #     atk
        #   ];
        # }

        extraCompatPackages = with pkgs; [ proton-ge-bin ];

        fontPackages = with pkgs; [ source-han-sans ];

        gamescopeSession = {     # enable starting games in an optimized compositor
          enable = true;
          # args = ;
          # env  = ;
        };

        protontricks = {         # simple wrapper for running Winetricks commands for Proton-enabled games
          enable  = false;
          package = pkgs.protontricks;
        };

        remotePlay.openFirewall               = false; # open ports for Steam Remote Play
        dedicatedServer.openFirewall          = false; # open ports for Source Dedicated Server
        localNetworkGameTransfers.openFirewall = false; # open ports for Steam Local Network Game Transfers
      };
    };
  };
}
