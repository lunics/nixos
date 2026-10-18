{
  # the transit key of the vaults it unseals only lives in this raft storage
  flake.aspects.openbao-unsealer.nixos = { config, lib, ... }:
  let
    snapshot = config._.openbao.snapshot;
  in {
    config = lib.mkIf snapshot.enable {
      systemd.tmpfiles.rules = [ "d ${snapshot.dir} 0700 root root -" ];

      systemd.services.openbao-snapshot = {
        description                  = "Snapshot the OpenBao raft storage";
        after                        = [ "openbao.service" ];
        requires                     = [ "openbao.service" ];
        path                         = [ config.services.openbao.package ];
        environment.BAO_ADDR         = config.environment.variables.BAO_ADDR;
        unitConfig.RequiresMountsFor = snapshot.dir;      # orders it after a shared mount
        serviceConfig = {
          Type             = "oneshot";
          UMask            = "0077";
          ImportCredential = "openbao-admin-token";
        };
        script = ''
          BAO_TOKEN=$(cat $CREDENTIALS_DIRECTORY/openbao-admin-token)
          export BAO_TOKEN
          bao operator raft snapshot save ${snapshot.dir}/unsealer-$(date +%F).snap
          find ${snapshot.dir} -name 'unsealer-*.snap' -mtime +${toString snapshot.keep-days} -delete
        '';
      };

      systemd.timers.openbao-snapshot = {
        wantedBy    = [ "timers.target" ];
        timerConfig = {
          OnCalendar         = "daily";
          Persistent         = true;                      # catches up a run missed while the machine was down
          RandomizedDelaySec = "1h";
        };
      };
    };
  };
}
