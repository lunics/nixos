{ config, lib, pkgs, ... }:{
  options._.user = {
    name = lib.mkOption {
      type    = lib.types.str;
      default = "";
    };
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
      type    = lib.types.package;
      default = pkgs.shadow;
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
}
