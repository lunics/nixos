{ config, pkgs, ... }:{
  services.mullvad-vpn = {
    enable  = config._.mullvad;
    package = pkgs.mullvad-vpn;
    enableExcludeWrapper = true;    # activates the wrapper that allows the use of mullvad-exclude
  };

  # environment.systemPackages = with pkgs; [
  #   mullvad               # cli client
  #   mullvad-vpn           # cli + gui client
  #   mullvad-compass       # find Mullvad servers with the lowest latency at your location
  # ];
}
