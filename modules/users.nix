{ config, pkgs, ... }:let _ = config._user; in {
  users = {
    users.lunics = {
      isNormalUser   = _.isNormalUser;
      isSystemUser   = _.isSystemUser;
      description    = _.description;
      uid            = _.uid;
      extraGroups    = _.extraGroups;
      # mkpasswd -m sha-512
      hashedPassword = _.hashedPassword;
      # password     = TODO SOPS;
      shell          = _.shell;
      ignoreShellProgramCheck = true;
      packages       = _.packages;
      openssh = {
        authorizedKeys.keys = _.authorizedKeys;   # /etc/ssh/authorized_keys.d/lunics
      };
    };

    # groups = {
    #   fuse = {    # A DELETE si anakama-launcher ne l'utilise pas
    #     members = [ "lunics" ];
    #   };
    # };
  };
}
