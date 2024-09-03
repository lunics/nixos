{
  networking = {
    hostName = "nixos"; # Define your hostname.

    nameservers = [
      # quad9
      "9.9.9.9"
      "149.112.112.112"
      "2620:fe::fe"
      "2620:fe::9"
      # local
      "192.168.1.1"
    ];

    # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
    # Configure network proxy if necessary
    # networking.proxy.default = "http://user:password@proxy:port/";
    # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";
    # Enable networking

    networkmanager = {
      enable = true;
    };
  };
}
