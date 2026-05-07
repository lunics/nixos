{
  flake.aspects.graphic.nixos = { config, lib, ... }:{
    services.xserver.videoDrivers = [ "nvidia" ];

    hardware.nvidia = {
      modesetting.enable = true; # required

      # save entire VRAM to /tmp/ on sleep/suspend to fix graphical corruption after wake
      powerManagement.enable = true;

      # experimental: turn off GPU when not in use (Turing or newer only)
      powerManagement.finegrained = true;

      # open source kernel module (not nouveau) — Turing+ only, from driver 515.43.04+
      open = true;

      nvidiaSettings = true;

      package = config.boot.kernelPackages.nvidiaPackages.production;

      # nvidia Optimus PRIME — switches between iGPU and dGPU
      # get bus IDs: nix shell nixpkgs#pciutils -c lspci | grep ' VGA '
      prime = {
        # pick ONE mode:
        # sync mode — best for desktop, keeps dGPU always on
        sync.enable = true;

        # offload mode — best for laptops, dGPU only when needed
        # offload = {
        #   enable = true;
        #   enableOffloadCmd = true; # provides: nvidia-offload GAME_NAME
        # };

        amdgpuBusID = "PCI:0:0:0"; # integrated (amd)
        intelBusId  = "PCI:0:0:0"; # integrated (intel)
        nvidiaBusID = "PCI:0:0:0"; # dedicated
      };
    };

    # generates 2 boot entries per generation to switch between offload and sync at boot
    specialisation.nvidia-sync.configuration = {
      system.nixos.tags = [ "nvidia-sync" ];
      hardware.nvidia = {
        powerManagement.finegrained    = lib.mkForce false;
        prime.offload.enable           = lib.mkForce false;
        prime.offload.enableOffloadCmd = lib.mkForce false;
        prime.sync.enable              = lib.mkForce true;
        dynamicBoost.enable            = lib.mkForce true; # shifts power between CPU and GPU dynamically
      };
    };
  };
}
