{
  flake.aspects = {
    options.generic = { lib, ... }: with lib; {
      # exposes the whole incus api over https, the web ui included
      options._.incus-https = {
        enable  = mkEnableOption "";
        address = mkOption {
          type    = types.str;
          default = "";           # "" = all interfaces, "127.0.0.1" = local only, "[::1]" for ipv6
        };
        port = mkOption {
          type    = types.port;
          default = 8443;
        };
        open-firewall = mkOption {
          type    = types.bool;
          default = false;
        };
      };
    };

    incus.nixos = { config, lib, ... }:
    let
      https = config._.incus-https;
    in lib.mkIf https.enable {
      # disabling it later does not unset core.https_address, the preseed never removes anything
      virtualisation.incus.preseed.config."core.https_address" = "${https.address}:${toString https.port}";

      networking.firewall.allowedTCPPorts = lib.mkIf https.open-firewall [ https.port ];
    };
  };
}
