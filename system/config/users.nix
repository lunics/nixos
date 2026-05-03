{ config, lib, pkgs, ... }:
let
  inherit (lib) mkOption types mkIf mapAttrs';
in {
  users.users = mapAttrs' (name: _user: {
    name = name;
    value = { 
      inherit (_user)
        uid
        shell
        description
        packages
        extraGroups
        isNormalUser
        isSystemUser
        hashedPassword
        ignoreShellProgramCheck;
      openssh.authorizedKeys.keys = _user.authorizedKeys;
    };
  }) config._.users;
}
