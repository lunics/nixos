{
  flake.aspects.options.generic = { lib, ... }: with lib; {
    options._ = {
      persistent-system = {
        dest = mkOption {
          type    = types.str;
          default = "/nix/persistent";
        };
        ephemeral-btrfs = mkOption {    # archive the root subvolume and recreate it empty at every boot
          type    = types.bool;
          default = true;
        };
        dirs = mkOption {
          type    = types.listOf (types.either types.path types.attrs);    # attrs: preservation directory submodule, eg. { directory = ...; mode = "0700"; }
          default = [];   # don't add paths here, they will be overwritten
          apply   = unique;    # several aspects may claim the same path
        };
        files = mkOption {
          type    = types.listOf (types.either types.path types.attrs);    # attrs: preservation file submodule, eg. { file = ...; inInitrd = true; }
          default = [];
          apply   = unique;
        };
      };

      persistent-home = {
        dest = mkOption {
          type    = types.str;
          default = "/nix/persistent";   # impermanence appends /home/<user> itself
        };
        dirs = mkOption {
          type    = types.listOf types.str;    # str: paths are relative to $HOME
          default = [];
          apply   = unique;    # impermanence refuses duplicated paths
        };
        files = mkOption {
          type    = types.listOf types.str;
          default = [];
          apply   = unique;
        };
      };
    };
  };
}
