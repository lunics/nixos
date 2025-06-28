{ pkgs, ... }:{
  programs.lutris = {
    enable = true;
    # extraPackages = with pkgs; [ 
    #   winetricks 
    #   # mangohud
    #   # gamescope     # already defined in system/gaming
    #   # gamemode
    #   umu-launcher
    #   protonup          # Proton GE
    #   # wine
    #   wine64
    #   # winetricks
    # ];
    # runners."name" = {
    #   package = ;
    #   settings = ;
    # };
    # OR
    # runners = {
    #   cemu.package = pkgs.cemu;
    #   pcsx2.config = {
    #     system.disable_screen_saver = true;
    #     runner.runner_executable = "$\{pkgs.pcsx2}/bin/pcsx2-qt";
    # };
    protonPackages = with pkgs; [ 
      protonup 
      # proton-ge-bin 
    ]; 
    winePackages = [ 
      wine64
      # pkgs.wineWow64Packages.full
    ];
    # steamPackage = pkgs.steam or osConfig.programs.steam.package;
  };
}
