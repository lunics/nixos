{
  flake.modules.nixos.vpn = { config, lib, pkgs, ... }: with lib; {
    config = mkIf config._.mullvad {
      services.mullvad-vpn = {
        enable  = true;
        package = pkgs.mullvad-vpn;
        enableExcludeWrapper = true;    # activates the wrapper that allows the use of mullvad-exclude
      };

      _.persistent.dirs = mkIf config._.impermanence [
        "/var/cache/mullvad-vpn"
      ];

      # environment.systemPackages = with pkgs; [
      #   mullvad               # cli client
      #   mullvad-vpn           # cli + gui client
      #   mullvad-compass       # find Mullvad servers with the lowest latency at your location
      # ];
    };
  };
}
