{ config, ... }: {
  imports = [ ./script.nix ];

  systemd.user = {
    services."flake-update" = {
      Unit.Description = "update all flake inputs";
      Service = {
        Type      = "oneshot";
        ExecStart = [ 
          "/home/lunics/.nix-profile/bin/flake-update"
        ];
      };
    };
  };
}
