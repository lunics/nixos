{ inputs, ... }:{
  flake-file.inputs.ableton-linux.url = "github:realitymolder/ableton-linux/flake";

  flake.aspects.ableton.nixos = { pkgs, ... }:{
    environment.systemPackages = [
      # patched Wine + PipeASIO + Ableton Link + desktop entries
      inputs.ableton-linux.packages.${pkgs.stdenv.hostPlatform.system}.default   

      # or pin the PipeASIO audio settings declaratively (exported as PIPEASIO_* overrides, config.ini stays untouched)
      # (inputs.ableton-linux.packages.${pkgs.stdenv.hostPlatform.system}.default.override {
      #   pipeasioSettings = {
      #     buffer_size = 256;            # frames, match the pipewire quantum
      #     inputs      = 2;              # hardware channel counts
      #     outputs     = 2;
      #     # sample_rate   = 48000;
      #     # output_device = "Scarlett 18i20";
      #   };
      # })
    ];

    boot.kernelModules = [ "ntsync" ];   # /dev/ntsync, needed by the wine runtime (kernel >= 6.14), check with: test -c /dev/ntsync

    # minimal pipewire requirements (>= 0.3.56, PipeASIO talks to it natively so jack isn't needed)
    security.rtkit.enable = true;  # realtime scheduling for the audio threads

    services.pipewire = {
      enable             = true;
      audio.enable       = true;
      wireplumber.enable = true;   # session manager, links PipeASIO to the hardware
    };
  };

  ## per user, once (the wine prefix lives in ~/.wine-ableton, a rebuild can't create it):
  ##   put the Ableton Live installation ZIP in ~/Proprietary, then
  ##   ABLETON_LIVE_AUTOINSTALL=1 nix run github:realitymolder/ableton-linux/flake#setup-prefix
  ##   nix run github:realitymolder/ableton-linux/flake#setup-realtime   # rtprio, swappiness, governor (sudo), musnix aspect already does it
  ##   nix run github:realitymolder/ableton-linux/flake#setup-link       # opens UDP 20808 + ableton-linkd user service
  ## first build compiles wine from source, no binary cache serves it
}
