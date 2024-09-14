{ lib, ... }:{

networking = {
  hostName = "nixos";

  useDHCP = lib.mkDefault true;
  # interfaces.wlp3s0.useDHCP    = lib.mkDefault true;

  networkmanager = {
    enable       = true;
    dhcp         = "internal";          # dhcpcd, internal
    dns          = "systemd-resolved";  # default (resolv.conf), dnsmasq, systemd-resolved, none
    enableStrongSwan = false;           # multiplatform IPsec implementation
    wifi = {
      backend    = "iwd";               # iwd, wpa_supplicant
      macAddress = "preserve";          # permanent", preserve, random, stable, stable-ssid
      scanRandMacAddress = true;        # Wifi random MAC address generation to avoid public tracking by MAC
    };
  };

  wireless.iwd = {
    enable = true;
    settings = {
      Network = {
        EnableIPv6           = false;
        RoutePriorityOffset  = 200;
        NameResolvingService = "resolvconf"; };

      Settings = {
        AutoConnect = true; };

      General = {
        EnableNetworkConfiguration = true; };

      Scan = {
        DisablePeriodicScan = false; };
    };
  };
};

{ ... }:

# Bluetooth
hardware.bluetooth.enable = true;
hardware.bluetooth.powerOnBoot = false;
services.blueman.enable = true;

services.resolved = {
  enable      = true;
  # dnssec      = "true";     # KO
  # dnsovertls  = "true";     # KO
  # domains     = [ "local" ];
  fallbackDns = [
    # quad9
    "9.9.9.9"
    "149.112.112.112"
    "2620:fe::fe"
    "2620:fe::9"

    # local
    "192.168.1.1"

    # fdn
    # "80.67.169.12"
    # "80.67.169.40"
    # "2001:910:800::12"
    # "2001:910:800::40"

    # cloudflare
    # "1.1.1.1"
    # "1.0.0.1"
    # "2606:4700:4700::1111"
    # "2606:4700:4700::1001"
  ];
};

}
