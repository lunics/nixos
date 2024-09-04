{ lib, ... }:{

  networking = {
    hostName = "nixos";

    useDHCP = lib.mkDefault true;
    # interfaces.enp0s31f6.useDHCP = lib.mkDefault true;
    # interfaces.wlp3s0.useDHCP    = lib.mkDefault true;
    # interfaces.wwan0.useDHCP     = lib.mkDefault true;

    nameservers = [
      # quad9
      "9.9.9.9"
      "149.112.112.112"
      "2620:fe::fe"
      "2620:fe::9"

      # local
      "192.168.1.1"

      # fdn
      "80.67.169.12"
      "80.67.169.40"
      "2001:910:800::12"
      "2001:910:800::40"

      # cloudflare
      # "1.1.1.1"
      # "1.0.0.1"
      # "2606:4700:4700::1111"
      # "2606:4700:4700::1001"
    ];

    # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
    # Configure network proxy if necessary
    # networking.proxy.default = "http://user:password@proxy:port/";
    # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";


    networkmanager = {
      enable = true;
    };
  };

  # services.resolved = {
  #   enable      = true;
  #   dnssec      = "true";
  #   dnsovertls  = "true";
  #   domains     = [ "local" ];
  #   fallbackDns = [
  #     # quad9
  #     "9.9.9.9"
  #     "149.112.112.112"
  #     "2620:fe::fe"
  #     "2620:fe::9"
  #
  #     # local
  #     "192.168.1.1"
  #   ];
  # };
}
