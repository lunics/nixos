{
  flake.aspects.llm.nixos = { config, lib, pkgs, ... }:{ 
    services.ollama = {
      enable = true;
      package = pkgs.ollama-cuda; # ollama-cuda for nvidia, ollama-rocm for amd
      environmentVariables = {};
      user  = "llm";              # system user account under which to run ollama, can't be a normal user
      group = config.services.ollama.user;
      home = "/var/lib/ollama";   # home directory that the ollama service is started in
      host = "127.0.0.1";         # ollama server HTTP interface listens to
      loadModels = [
        "qwen3.6:27B"
        # "dolphin3"
        # "gemma3"
        # "gemma3:27b"
        # "deepseek-r1:latest"
        # "deepseek-r1:1.5b"
      ];
      models = "${config.services.ollama.home}/models";    # The directory that the ollama service will read models from and download new models to
      openFirewall = true;      # adds services.ollama.port to networking.firewall.allowedTCPPorts
      port = 11434;
      syncModels = false;     # synchronize all currently installed models with those declared in loadModels, removing any others models installed but not declared
    };
    hardware.graphics.enable = true;
    hardware.nvidia.open = true;
    nixpkgs.config.cudaSupport = true;
    services.xserver.videoDrivers = ["nvidia"];
    nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
      "nvidia-x11"
      "nvidia-settings"
    ];
  };
}
