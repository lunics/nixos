{ pkgs, ... }:{
  services.mullvad-vpn = {
    enable  = true;
    package = pkgs.mullvad-vpn;     # mullvad only CLI tool, mullvad-vpn for CLI + GUI
  };

  environment.systemPackages = with pkgs; [
    mullvad               # cli client
    mullvad-vpn           # cli + gui client
    mullvad-closest       # find Mullvad servers with the lowest latency at your location
  ];
}
