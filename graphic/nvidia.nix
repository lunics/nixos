{ config, lib, ... }:{
  hardware.nvidia = {
    modesetting.enable = true;        #  required

    # Nvidia power management. Experimental, and can cause sleep/suspend to fail.
    # Enable this if you have graphical corruption issues or application crashes after waking
    # up from sleep. This fixes it by saving the entire VRAM memory to /tmp/ instead
    # of just the bare essentials.
    powerManagement.enable = true;

    # Fine-grained power management. Turns off GPU when not in use.
    # Experimental and only works on modern Nvidia GPUs (Turing or newer).
    powerManagement.finegrained = true;

    # Use the NVidia open source kernel module (not to be confused with the
    # independent third-party "nouveau" open source driver).
    # Support is limited to the Turing and later architectures. Full list of
    # supported GPUs is at:
    # https://github.com/NVIDIA/open-gpu-kernel-modules#compatible-gpus
    # Only available from driver 515.43.04+
    # Currently alpha-quality/buggy, so false is currently the recommended setting.
    open = true;

    # Enable the Nvidia settings menu,
  	# accessible via `nvidia-settings`.
    nvidiaSettings = true;

    # Optionally, you may need to select the appropriate driver version for your specific GPU.
    package = config.boot.kernelPackages.nvidiaPackages.production;

    # Nvidia Optimus PRIME. It is a technology developed by Nvidia to optimize
    # the power consumption and performance of laptops equipped with their GPUs.
    # It seamlessly switches between the integrated graphics,
    # usually from Intel, for lightweight tasks to save power,
    # and the discrete Nvidia GPU for performance-intensive tasks.
    prime = {     # 2 different modes
      # sync mode
        # best mode for desktop/powerfull pc
        sync.enable = true    # keep dedicated GPU running at all times improving game performance

      # offload mode
        # best mode for laptop
        offload = {           # dedicated GPU is only enabled when needed, optimizing power consumtion
          enable = true;
          enableOffloadCmd = true;
            # enable cmd: nvidia-offload GAME_NAME, nvidia-offload %command%
        };

      # getting IDs: nix shell nixpkgs#pciutils -c lspci | grep ' VGA '
      amdgpuBusID = "PCI:0:0:0";        # integrated
      intelBusID  = "PCI:0:0:0";        # integrated
      nvidiaBusID = "PCI:0:0:0";        # dedicated
  	};
  };

  # Load nvidia driver for Xorg and Wayland
  services.xserver.videoDrivers = ["nvidia"];

  # will generates 2 boot entries at every generations allowing to choose desire mode at boot
  # NixOS specialization named 'nvidia-sync'. Provides the ability
  # to switch the Nvidia Optimus Prime profile
  # to sync mode during the boot process, enhancing performance.
  specialisation = {
    nvidia-sync.configuration = {
      system.nixos.tags = [ "nvidia-sync" ];
      hardware.nvidia = {
        powerManagement.finegrained = lib.mkForce false;

        prime.offload.enable = lib.mkForce false;
        prime.offload.enableOffloadCmd = lib.mkForce false;

        prime.sync.enable = lib.mkForce true;
        # Dynamic Boost. It is a technology found in NVIDIA Max-Q design laptops with RTX GPUs.
        # It intelligently and automatically shifts power between
        # the CPU and GPU in real-time based on the workload of your game or application.
        dynamicBoost.enable = lib.mkForce true;
      };
    };
  };
}
