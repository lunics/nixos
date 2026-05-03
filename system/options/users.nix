{ config, lib, pkgs, ... }: with lib; {
  options._.users = mkOption {
    type = types.attrsOf (types.submodule ({ config, name, ... }: {
      options = {
        uid = mkOption {
          type    = types.nullOr types.int;
          default = null;             # if null a free UID is picked on activation
        };
        hashedPassword = mkOption {
          type    = types.str;
          default = "";
        };
        extraGroups = mkOption {
          type    = types.listOf types.str;
          default = [];
        };
        shell = mkOption {
          type    = types.nullOr (types.either types.shellPackage (types.passwdEntry types.path));
          default = pkgs.shadow;
        };
        ignoreShellProgramCheck = mkOption {
          type    = types.bool;
          default = true;
        };
        packages = mkOption {
          type    = types.listOf types.package;
          default = [];
        };
        isNormalUser = mkOption {
          type    = types.bool;
          default = true;
        };
        isSystemUser = mkOption {
          type    = types.bool;
          default = false;
        };
        description = mkOption {
          type    = types.str;
          default = "";
        };
        authorizedKeys = mkOption {
          type    = types.listOf types.str;
          default = [];
        };
      };
    }));
  };
}
