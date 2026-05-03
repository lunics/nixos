{ config, ... }:{
  programs.gamemode = {
    enable       = config._.gamemode;    # daemon that greatly improve game's performance, applying temporary optimizations to the OS and game process
    enableRenice = true;    # enable CAP_SYS_NICE on gamemoded to support lowering process niceness
    # settings = {
    #   general = {
    #     renice = 10;
    #   };
    
    #   # Warning: GPU optimisations have the potential to damage hardware
    #   gpu = {
    #     apply_gpu_optimisations = "accept-responsibility";
    #     gpu_device = 0;
    #     amd_performance_level = "high";
    #   };
    
    #   custom = {
    #     start = "${pkgs.libnotify}/bin/notify-send 'GameMode started'";
    #     end = "${pkgs.libnotify}/bin/notify-send 'GameMode ended'";
    #   };
    # };
  };
}
