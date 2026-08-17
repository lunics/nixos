{
  flake.aspects = {
    options.generic = { lib, ... }: with lib; {
      options._.cifs = {
        server = mkOption {
          type    = types.str;
          default = "";        # ip or hostname
        };
        shares = mkOption {
          type    = types.listOf types.str;
          default = [];
        };
        mount_root = mkOption {
          type    = types.str;
          default = "/mnt";
        };
        secret = mkOption {
          type    = types.str;
          default = "";       # sops-nix secret name
        };
      };
    };

    disk.nixos = { config, lib, pkgs, ... }: with lib;
    let
      cifs = config._.cifs;
    in mkIf (cifs.server != "" && cifs.shares != []) {
      environment.systemPackages = with pkgs; [
        cifs-utils
      ];

      assertions = [{
        assertion = config.sops.secrets ? "${cifs.secret}";
        message   = "sops: missing ${cifs.secret} secret";
      }];

      fileSystems = listToAttrs (map (share:
        nameValuePair "${cifs.mount_root}/${cifs.server}/${share}" {
          device  = "//${cifs.server}/${share}";
          fsType  = "cifs";
          options = [
            "credentials=${config.sops.secrets."${cifs.secret}".path}"
            "uid=${toString config._.user_id}"
            "gid=100"                       # users
            "file_mode=0644"                # must change if its a group-writable share
            "dir_mode=0755"                 # //
            "vers=3.1.1"
            "iocharset=utf8"
            "nofail"                        # never block boot when the share is unreachable
            "_netdev"
            "noauto"                        # mounted on first access, by the automount unit
            "x-systemd.automount"
            "x-systemd.idle-timeout=600"
            "x-systemd.mount-timeout=10s"
            "x-systemd.after=sops-nix.service"
            "x-systemd.requires=sops-nix.service"
          ] ++ optionals config.services.tailscale.enable [
            "x-systemd.after=tailscaled.service"        # mount cifs after tailscale is ready
            "x-systemd.requires=tailscaled.service"
          ];
        }) cifs.shares);
    };
  };
}
