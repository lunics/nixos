{
  targets.genericLinux.nixGL = {      # wrapper tool for nix OpenGL 
    defaultWrapper = "mesaPrime";     # mesa, mesaPrime, nvidia, nvidiaPrime
    offloadWrapper = "mesaPrime";     # mesa, mesaPrime, nvidia, nvidiaPrime

    vulkan.enable  = true;            # can cause symbol version conflicts in wrapped programs

    prime = {
      card           = "";            # non-default graphics card used for PRIME render offloading
      installScript  = "mesa";        # "mesa", "nvidia"
      nvidiaProvider = "";            # overrides the offload provider for Nvidia PRIME offloading
    };
    # installScripts = [
    #   "mesa"
    #   "mesaPrime"
    # ]
    # packages = inputs.nixGL.packages;
  };
}
