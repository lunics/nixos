{
  flake.aspects.gaming-nixos.nixos = { config, ... }:{
    programs.gamemode = {
      enable       = config._.gamemode; # daemon that greatly improves game performance by applying temporary OS optimizations
      enableRenice = true;              # enable CAP_SYS_NICE on gamemoded to support lowering process niceness
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
  };
}
