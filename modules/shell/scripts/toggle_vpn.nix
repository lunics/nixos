self: super: {
  toggle_vpn = super.writeShellApplication {
    name = "toggle_vpn";

    excludeShellChecks = [ "SC2086" "SC2046" "SC1091" ];

    text = ''
      if mullvad status | head -1 | grep -i disconnected; then
        mullvad connect
      else
        mullvad disconnect
      fi
    '';
  };
}
