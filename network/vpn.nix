{ pkgs, ... }:{
  services.mullvad-vpn = {
    enable  = false;
    package = pkgs.mullvad;   # mullvad only CLI tool, mullvad-vpn for CLI + GUI
  };

  environment.systemPackages = with pkgs; [
    # openvpn
    mullvad-closest
  ];
}
