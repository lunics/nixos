{ pkgs, ... }:{
  home.packages = with pkgs; [
    winboat
    # (unstable.winboat.override {nodejs_24 = pkgs.nodejs_24;})
    # freerdp
  ];
}

# virtualisation.docker.enable = true;

# virtualisation.docker.daemon.settings = {
#   userland-proxy = false;
#   experimental = true;
#   ipv6 = true;
#   "fixed-cidr-v6" = "fd00::/80";
# };
