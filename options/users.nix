{ config, lib, pkgs, ... }:{
  options._.users = lib.mkOption {
    type = lib.types.attrsOf (lib.types.submodule ({ config, name, ... }: {
      options = {
        uid = lib.mkOption {
          type    = lib.types.nullOr lib.types.int;
          default = null;             # if null a free UID is picked on activation
        };
        hashedPassword = lib.mkOption {
          type    = lib.types.str;
          default = "";
        };
        extraGroups = lib.mkOption {
          type    = lib.types.listOf lib.types.str;
          default = [];
        };
        shell = lib.mkOption {
          type    = lib.types.str;
          default = "";
        };
        packages = lib.mkOption {
          type    = lib.types.listOf lib.types.package;
          default = [];
        };
        isNormalUser = lib.mkOption {
          type    = lib.types.bool;
          default = true;
        };
        isSystemUser = lib.mkOption {
          type    = lib.types.bool;
          default = false;
        };
        description = lib.mkOption {
          type    = lib.types.str;
          default = "";
        };
        authorizedKeys = lib.mkOption {
          type    = lib.types.listOf lib.types.str;
          default = [];
        };
      };
    }));
  };
}
