{
  flake.aspects.user-admin.nixos = { config, pkgs, ... }:{
    users.users.admin = {
      uid          = 10001;
      description  = "admin";
      isNormalUser = true;
      extraGroups  = ["wheel" "sops"];
      shell        = pkgs.bash;
      createHome   = true;
      packages     = with pkgs; [];
      hashedPasswordFile = "/run/secrets/user/admin/passwd";
    };

    _.nix.trusted-users = ["admin"];

    services.openssh.authorizedKeysFiles = ["/run/secrets/user/admin/ssh/servers"];
  };
}
