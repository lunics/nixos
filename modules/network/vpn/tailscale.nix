{
  flake.aspects.tailscale = {
    nixos = { config, options, lib, pkgs, ... }:{
      services.tailscale = {
        enable             = true;
        useRoutingFeatures = "client";
        extraDaemonFlags   = [ "--no-logs-no-support" ];
        extraUpFlags       = [ "--accept-dns=false" ];
        # authKeyFile      = config.age.secrets.tailscaleAuthKey.path;
      };
      # seed the node identity on first boot only, tailscaled owns the file afterwards
      systemd.services.tailscaled.preStart = lib.optionalString
        ((options ? sops) && (config.sops.secrets ? "tailscaled-state")) ''
          if [ ! -e /var/lib/tailscale/tailscaled.state ]; then
            install -m 0600 -o root -g root ${config.sops.secrets."tailscaled-state".path} /var/lib/tailscale/tailscaled.state
          fi
        '';

      environment.systemPackages = [ pkgs.tailscale ];

      _.persistent.dirs = lib.mkIf config._.impermanence [ "/var/lib/tailscale" ];

      # networking.firewall = {
      #   allowedUDPPorts   = [ config.services.tailscale.port ];
      #   trustedInterfaces = [ "tailscale0" ];
      # };
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
