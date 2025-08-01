{ config, lib, pkgs, ... }:let
  inherit (lib) mkOption types mkIf mapAttrs';
in {
  users.users = mapAttrs' (name: _user: {
    name = name;
    value = { 
      inherit (_user)
        uid
        description
        packages
        extraGroups
        isNormalUser
        isSystemUser
        hashedPassword;
      shell = if _user.shell == "bash" then pkgs.bash
         else if _user.shell == "zsh"  then pkgs.zsh
         else pkgs.shadow;
      openssh.authorizedKeys.keys = _user.authorizedKeys;
    };
  }) config._.users;

  #   # groups = {
  #   #   fuse = {    # A DELETE si anakama-launcher ne l'utilise pas
  #   #     members = [ "lunics" ];
  #   #   };
  #   # };
  # };
}
