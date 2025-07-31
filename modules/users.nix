{ config, lib, pkgs, ... }:let
  inherit (lib) mkOption types mkIf mapAttrs';
in {
  # v2
  users.users = mapAttrs' (name: userCfg: {
    name = name;
    value = { 
      inherit (userCfg)
        uid
        description
        packages
        extraGroups
        isNormalUser
        isSystemUser
        hashedPassword;
      shell = if userCfg.shell == "bash" then pkgs.bash
         else if userCfg.shell == "zsh"  then pkgs.zsh;
      openssh.authorizedKeys.keys = userCfg.authorizedKeys;
    };
  }) config._.users;

  # v1
  # users = {
  #   users.lunics = {
  #     isNormalUser   = _.isNormalUser;
  #     isSystemUser   = _.isSystemUser;
  #     description    = _.description;
  #     uid            = _.uid;
  #     extraGroups    = _.extraGroups;
  #     # mkpasswd -m sha-512
  #     hashedPassword = _.hashedPassword;
  #     # password     = TODO SOPS;
  #     shell          = _.shell;
  #     ignoreShellProgramCheck = true;
  #     packages       = _.packages;
  #     openssh = {
  #       authorizedKeys.keys = _.authorizedKeys;   # /etc/ssh/authorized_keys.d/lunics
  #     };
  #   };

  #   # groups = {
  #   #   fuse = {    # A DELETE si anakama-launcher ne l'utilise pas
  #   #     members = [ "lunics" ];
  #   #   };
  #   # };
  # };
}
