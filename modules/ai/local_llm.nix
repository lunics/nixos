{
  flake.aspects.llm.nixos = { config, lib, pkgs, ... }:{ 
    services.ollama = {
      enable = true;
      package = pkgs.ollama-cuda;   # ollama-cuda for nvidia, ollama-rocm for amd
      environmentVariables = {};
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
