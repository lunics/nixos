{ config, lib, pkgs, inputs, ... }:{
  imports = [ inputs.musnix.nixosModules.musnix ];

  config = lib.mkIf config._.audio {
    musnix = {
      # list options run: nixos-option musnix.rtirq or nixos-option musnix.rtirq.enable
      enable         = true;
      alsaSeq.enable = true;                # load ALSA Sequencer kernel modules
      ffado.enable   = false;               #  use the Free FireWire Audio Drivers (FFADO)
      rtcqs.enable   = false;               # install the rtcqs command-line utulity
      # soundcardPciId = "00:1b.0"          #  PCI ID of the primary soundcard, used to set the PCI latency timer
      kernel = {
        realtime = false;                   # if true will rebuild the kernel to apply CONFIG_PREEMPT_RT
        packages = pkgs.linuxPackages_rt;   # select the real-time kernel used by musnix
          # or pkgs.linuxPackages_latest_rt
      };
      # das_watchdog.enable = false;        # start the das_watchdog service to ensure that a realtime process won't hang the machine, true if musnix.kernel.realtime = true, otherwise false
    };
    users.users.${config._.user}.extraGroups = [ "audio" ];   # required by musnix

    security.rtkit.enable      = true;
    services.pulseaudio.enable = false;
    
    services.pipewire = {
      enable               = true;
      audio.enable         = true;
      wireplumber.enable   = true;
      pulse.enable         = true;
      alsa.enable          = true;
      alsa.support32Bit    = true;
      jack.enable          = true; 
    };
  };
}
