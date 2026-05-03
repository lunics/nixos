{ config, lib, pkgs, ... }:{
  config = lib.mkIf config._.graphic {
    ## test VA/video acceleration: nix-shell -p libva-utils --run vainfo

    # enable OpenGL
    # can be enabled on any gpu nvidi/amd
    # hardware.opengl is deprecated
    hardware.graphics = {
      enable = true;
      extraPackages = with pkgs; [
        vpl-gpu-rt              # to enable video acceleration (for OBS Studio, ffmpeg, ...) via Intel Quick Sync Video (QSV) through Intel VPL
        intel-vaapi-driver      # LIBVA_DRIVER_NAME=i965 (older but works better for Firefox/Chromium)
        intel-media-driver      # LIBVA_DRIVER_NAME=iHD
        libvdpau-va-gl
        # intel-compute-runtime
        # vaapiVdpau
        # mesa
        # nvidia-vaapi-driver
        # nv-codec-headers-12
        # amdvlk                # amd vulkan
      ];

      # enable32Bit = true;
      # extraPackages32 = with pkgs.pkgsi686Linux; [
      #   intel-media-driver
      #   intel-vaapi-driver
      #   vaapiVdpau
      #   mesa
      #   libvdpau-va-gl
      # ];
    };

    # nixpkgs.config.packageOverrides = pkgs: {
    #   intel-vaapi-driver = pkgs.intel-vaapi-driver.override { enableHybridCodec = true; };
    # };
  };
}
