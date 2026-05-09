{ pkgs, ... }:{
  programs.lutris = {
    enable = true;
    extraPackages = with pkgs; [ 
      wine
      winetricks 
      mangohud

      # vulkan-helper     # doesn't fix [ERROR:2025-06-28 19:15:32,566:system]: ['vulkaninfo', '--summary'] command failed
      # gamescope         # already defined in system/gaming
      # gamemode
      # protonup          # Proton GE
    ];

    # runners = {   KO
    #   "wine".package = pkgs.wine64;
    # };

    # OR
    # runners = {
    #   cemu.package = pkgs.cemu;
    #   pcsx2.config = {
    #     system.disable_screen_saver = true;
    #     runner.runner_executable = "$\{pkgs.pcsx2}/bin/pcsx2-qt";
    # };
    # protonPackages = with pkgs; [ 
    #   protonup 
    #   # proton-ge-bin 
    # ]; 
    # winePackages = with pkgs; [ 
    #   wine64
    #   # pkgs.wineWow64Packages.full
    # ];
    # steamPackage = pkgs.steam or osConfig.programs.steam.package;
  };
}
