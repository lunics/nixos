{
  flake.aspects.llm.nixos = { config, lib, pkgs, ... }:{ 
    systemd.tmpfiles.rules = [
      "Z /var/lib/private/ollama 0700 llm llm -"
    ];

    services.ollama = {
      enable       = true;
      package      = pkgs.ollama-cuda;    # ollama-cuda for nvidia, ollama-rocm for amd
      user         = "llm";               # system user account under which to run ollama, can't be a normal user
      group        = config.services.ollama.user;
      home         = "/var/lib/ollama";   # home directory that the ollama service is started in
      host         = "127.0.0.1";         # ollama server HTTP interface listens to
      models       = "${config.services.ollama.home}/models";    # The directory that the ollama service will read models from and download new models to
      openFirewall = true;                # adds services.ollama.port to networking.firewall.allowedTCPPorts
      port         = 11434;
      syncModels   = false;               # synchronize all currently installed models with those declared in loadModels, removing any others models installed but not declared
      environmentVariables = {
        CUDA_VISIBLE_DEVICES   = config._.gpu-nvidia-uuid;
        OLLAMA_FLASH_ATTENTION = "1";       # set to 1 if GPU supports Flash Attention
        OLLAMA_KV_CACHE_TYPE   = "q8_0";    # fp16 (default), q8_0, q4_0
        # OLLAMA_CONTEXT_LENGTH  = "32000"; # set to 4GB ?
        OLLAMA_KEEP_ALIVE      = "24h";     # 5m (default) of inactivity before ollama unload models
      };
      loadModels = [
        # "qwen3.6:27B"
        # "dolphin3"
        # "gemma3"
        # "gemma3:27b"
        # "deepseek-r1:latest"
        # "deepseek-r1:1.5b"
      ];
    };

    services.open-webui = {
      enable       = true;
      package      = pkgs.open-webui;
      host         = "127.0.0.1";
      openFirewall = true;
      port         = 8080;
      stateDir     = "/var/lib/open-webui";
      environment = {
        OLLAMA_API_BASE_URL  = "http://127.0.0.1:11434";
        DO_NOT_TRACK         = "True";
        SCARF_NO_ANALYTICS   = "True";
        ANONYMIZED_TELEMETRY = "False";
        WEBUI_AUTH           = "False";
        HOME                 = "/home/llm";
      };
      environmentFile = null;
    };

    hardware.graphics.enable = true;
    hardware.nvidia = {
      # modesetting.enable = true;
      # powerManagement.enable = false;
      open = true;
      # nvidiaSettings = true;
      # package = config.boot.kernelPackages.nvidiaPackages.stable;
    };
    # environment.systemPackages = with pkgs; [
    #   cudatoolkit
    # ]
    # hardware.opengl.enable = true;
    services.xserver.videoDrivers = ["nvidia"];
    # nixpkgs.config.cudaSupport = true;
    # nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    #   "nvidia-x11"
    #   "nvidia-settings"
    # ];
  };
}
