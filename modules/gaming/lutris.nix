{
  flake.aspects.lutris.homeManager = { pkgs, ... }:{
    programs.lutris = {
      enable  = true;
      package = pkgs.lutris;
      defaultWinePackage = pkgs.proton-ge-bin;
      protonPackages = with pkgs; [      # proton packages used by umu-launcher
        proton-ge-bin 
        # protonup-ng
      ];
      extraPackages = with pkgs; [ 
        # wine
        # winetricks 
        # mangohud
        # vulkan-helper     # doesn't fix [ERROR:2025-06-28 19:15:32,566:system]: ['vulkaninfo', '--summary'] command failed
        # protonup          # Proton GE
      ];
      runners = {
        # "wine".package = pkgs.wine64;
        #  cemu.package = pkgs.cemu;
        #  pcsx2.config = {
        #    system.disable_screen_saver = true;
        #    runner.runner_executable = "$\{pkgs.pcsx2}/bin/pcsx2-qt";
      };
      winePackages = with pkgs; [ 
        # wineWow64Packages.waylandFull
      ];
      # steamPackage = osConfig.programs.steam.package;
    };
  };
}
