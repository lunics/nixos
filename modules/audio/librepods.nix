{
  flake.aspects.librepods.homeManager = { pkgs, ... }:{
    home.packages = with pkgs; [
      librepods
    ];

    _.add_to_startup = [ "librepods --hide" ];

    xdg.configFile."wireplumber/wireplumber.conf.d/51-bluez-avrcp.conf" = {
      force = true;    # take over the plain file already present in ~/.config
      text  = ''
        monitor.bluez.properties = {
          # Enable dummy AVRCP player for proper media control support
          # This is required for AirPods and other devices to send play/pause/skip commands
          bluez5.dummy-avrcp-player = true
        }
      '';
    };
  };
}
