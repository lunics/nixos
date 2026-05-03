{ config, lib, ... }:{
  imports = [
    ./iwd.nix
  ];

  _.persistent.dirs = lib.mkIf config._.impermanence [ 
    "/etc/NetworkManager/system-connections"    ## move in wifi_profiles once ready
  ];
}
