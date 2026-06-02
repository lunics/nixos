{
  flake.aspects.k3s.nixos = { config, lib, pkgs, ... }: let
    k3s = config._.k3s;
  in {
    config = lib.mkIf k3s.enable {
      users.users.${k3s.user} = {
        uid          = 10002;
        description  = k3s.user;
        isNormalUser = true;
        shell        = pkgs.bash;
        createHome   = true;
        packages     = with pkgs; [];
        hashedPasswordFile = "/run/secrets/user/${k3s.user}/passwd";
      };

      services.openssh.authorizedKeysFiles = ["/run/secrets/user/${k3s.user}/ssh/servers"];
    };
  };
}
