{ config, pkgs, ... }:{
  
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
  
  environment.systemPackages = with pkgs; [
    pamixer
    pavucontrol
  ];
}
