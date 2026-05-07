{
  flake.aspects.graphic.nixos = { config, lib, pkgs, ... }:{
    ## test VA/video acceleration: nix-shell -p libva-utils --run vainfo
    config = lib.mkIf config._.graphic {
      hardware.graphics = {
        enable = true;
        # enable32Bit = true;
        # package32 = pkgs-unstable.pkgsi686Linux.mesa;

        extraPackages = with pkgs; [
          vpl-gpu-rt         # intel Quick Sync Video (QSV) via Intel VPL
          intel-vaapi-driver # LIBVA_DRIVER_NAME=i965 (older but works better for Firefox/Chromium)
          intel-media-driver # LIBVA_DRIVER_NAME=iHD
          libvdpau-va-gl
          # intel-compute-runtime
          # vaapiVdpau
          # mesa
          # nvidia-vaapi-driver
          # nv-codec-headers-12
          # amdvlk             # amd vulkan
        ];

        # extraPackages32 = with pkgs.pkgsi686Linux; [
        #   intel-media-driver
        #   intel-vaapi-driver
        #   vaapiVdpau
        #   mesa
        #   libvdpau-va-gl
        # ];
      };
    };
  };
}
