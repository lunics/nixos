{
  flake.modules.nixos.wifi = { config, lib, ... }: with lib; {
    networking.networkmanager.ensureProfiles.profiles = mapAttrs (ssid: psk: {
      connection = {
        id   = ssid;
        type = "wifi";
      };

      wifi = {
        mode = "infrastructure";
        ssid = ssid;
      };

      wifi-security.psk = psk;

      ipv4.method = "auto";

      ipv6 = {
        addr-gen-mode = "default";
        method        = "auto";
      };
    }) config._.wifi;

    _.persistent.dirs = mkIf config._.impermanence [
      "/etc/NetworkManager/system-connections"
    ];
  };
}
