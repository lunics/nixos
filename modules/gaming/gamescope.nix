{ config, ... }:{
  programs.gamescope = {
    enable     = config._.gamescope;
    capSysNice = false;       # Add cap_sys_nice capability to the GameScope binary so that it may renice itself
    # env = {
    #   __NV_PRIME_RENDER_OFFLOAD = "1";
    #   __VK_LAYER_NV_optimus = "NVIDIA_only";
    #   __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    # }
    # args = [
    #   "--rt"
    #   "--prefer-vk-device 8086:9bc4"
    # ];
  };
}
