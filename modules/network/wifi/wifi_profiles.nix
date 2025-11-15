{ config, lib, ... }:{
  networking.networkmanager.ensureProfiles.profiles = lib.mapAttrs (ssid: psk: {
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
}
