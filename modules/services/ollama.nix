{
  services.ollama = {
    enable = true;
    host   = "127.0.0.1";   # the ollama server HTTP interface listens to
    port   = 11434;
    acceleration = null;    # rocm for AMD GPUs, cuda for NVIDIA GPUs
    # package = pkgs.ollama;
    # environmentVariables = {    # only seen by the ollama server/systemd service, not normal invocations like ollama run
    #   HIP_VISIBLE_DEVICES = "0,1";
    #   OLLAMA_LLM_LIBRARY = "cpu";
    # };
  };
}
