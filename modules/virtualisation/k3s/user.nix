{
  flake.aspects.k3s.nixos = { config, options, lib, pkgs, ... }: with lib; let
    k3s = config._.k3s;
    has-sops-passwd = (options ? sops) && (config.sops.secrets ? "user/${k3s.user}/passwd");
  in {
    config = mkMerge [
      (mkIf k3s.enable && has-sops-passwd {
        users.users.${k3s.user} = {
          uid          = 10002;
          description  = k3s.user;
          isNormalUser = true;
          shell        = pkgs.bash;
          createHome   = true;
          packages     = with pkgs; [];
          hashedPasswordFile = mkMerge [
            (mkIf (config._.from == "host")
              config.sops.secrets."user/${k3s.user}/passwd".path)
            # (mkIf (config._.from == "guest")
            #   "/run/secrets/user/${k3s.user}/passwd")
          ];
        };
      })
      # (mkIf (k3s.enable && config._.from == "guest") {
      #   systemd.tmpfiles.rules = [
      #     "z /run/secrets/user/${k3s.user}/ssh/servers 0400 ${k3s.user} -"
      #   ];
      # })
    ];
  };
}
