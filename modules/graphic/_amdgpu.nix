{
  flake.aspects.graphic.nixos = { pkgs, ... }:{
    services.xserver.videoDrivers = [ "amdgpu" ];

    # lact: overclock, undervolt, set fan curves of AMD GPUs on Linux
    environment.systemPackages = with pkgs; [ lact ];
    systemd = {
      packages = with pkgs; [ lact ];
      services.lactd.wantedBy = [ "multi-user.target" ];
    };

    # todo: https://nixos.wiki/wiki/AMD_GPU
  };
}
