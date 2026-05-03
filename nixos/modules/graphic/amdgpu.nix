{ pkgs, ... }:{
  services.xserver.videoDrivers = ["amdgpu"];
  
  # This application allows you to overclock, undervolt, set fans curves of AMD GPUs on a Linux system
  environment.systemPackages = with pkgs; [ lact ];
  systemd = {
    packages = with pkgs; [ lact ];
    services.lactd.wantedBy = ["multi-user.target"];
  };

  # todo: https://nixos.wiki/wiki/AMD_GPU
}
