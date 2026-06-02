{
  flake.aspects.user-admin.nixos = { config, lib, pkgs, ... }: with lib; {
    users.users.admin = {
      uid          = 10001;
      description  = "admin";
      isNormalUser = true;
      extraGroups  = ["wheel" "sops"];
      shell        = pkgs.bash;
      createHome   = true;
      packages     = with pkgs; [];
      hashedPasswordFile = mkMerge [
        (mkIf (config._.from == "host")
          config.sops.secrets."user/admin/passwd".path)
        (mkIf (config._.from == "guest")
          "/run/secrets/user/admin/passwd")
      ];
    };
      
    _.nix.trusted-users = ["admin"];

    services.openssh.authorizedKeysFiles = ["/run/secrets/user/admin/ssh/servers"];
  };
}
