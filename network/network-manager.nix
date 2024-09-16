{
  networking.networkmanager = {
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
}
