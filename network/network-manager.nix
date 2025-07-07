{ pkgs, ... }:{
  ## Set Network Manager Priority to Use Wired Connection Over Wi-Fi
  networking.networkmanager = {
    enable       = true;
    dhcp         = "internal";          # dhcpcd, internal
    dns          = "systemd-resolved";  # default (resolv.conf), dnsmasq, systemd-resolved, none

    wifi = {
      backend    = "iwd";               # iwd, wpa_supplicant
      macAddress = "preserve";          # permanent", preserve, random, stable, stable-ssid
      scanRandMacAddress = true;        # Wifi random MAC address generation to avoid public tracking by MAC
    };

    plugins = with pkgs; [
      networkmanager-openvpn
      # networkmanager-strongswan           # multiplatform IPsec implementation
      # networkmanager-openconnect
      # networkmanager-fortisslvpn
      # networkmanager-iodine
      # networkmanager-l2tp
      # networkmanager-vpnc
      # networkmanager-sstp
    ];
  };

  # imports = [
  #   ../etc/NetworkManager/
  # ];
}
