{
  flake.aspects.tailscale = {
    nixos = { pkgs, ... }:{
      services.tailscale = {
        enable             = true;
        useRoutingFeatures = "client";
        extraDaemonFlags   = [ "--no-logs-no-support" ];
        extraUpFlags       = [ "--accept-dns=false" ];
      };
      environment.systemPackages = [ pkgs.tailscale ];
    };

    homeManager = { pkgs, lib, osConfig, ... }:{
      home.packages = lib.optional
        (osConfig != null && osConfig.services.desktopManager.plasma6.enable)
          pkgs.tail-tray;

      services.tailscale-systray = {
        enable = true;
        theme  = "dark";    # null, dark, dark:nobg, light, light:nobg
      };

      # xdg.configFile."autostart/tail-tray.desktop".text = ''
      #   [Desktop Entry]
      #   Categories=Qt;KDE;Utility;X-Networking;X-Internet;X-VPN;
      #   Comment=Tailscale Tray Application
      #   Exec=${pkgs.tail-tray}/bin/tail-tray
      #   GenericName=Tail Tray
      #   Icon=tail-tray
      #   Name=Tail Tray
      #   NoDisplay=false
      #   StartupNotify=true
      #   Terminal=false
      #   Type=Application
      #   X-DarkIcon=tail-tray-dark
      #   X-LightIcon=tail-tray
      # '';
    };
  };
}
