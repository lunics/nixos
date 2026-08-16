{ inputs, ... }:{
  flake-file.inputs.ableton-linux.url = "github:realitymolder/ableton-linux/flake";

  flake.aspects.ableton = {
    nixos = { pkgs, ... }:{
      environment.systemPackages = [
        inputs.ableton-linux.packages.${pkgs.stdenv.hostPlatform.system}.default
      ];

      boot.kernelModules = [ "ntsync" ];   # /dev/ntsync, needed by the wine runtime

      # minimal pipewire requirements (PipeASIO talks to it natively so jack isn't needed)
      security.rtkit.enable = true;  # realtime scheduling for the audio threads

      services.pipewire = {
        enable             = true;
        audio.enable       = true;
        wireplumber.enable = true;   # session manager, links PipeASIO to the hardware
      };
    };
  };
}
