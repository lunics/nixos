{
  flake.aspects.options.generic = { lib, ... }: with lib; {
    options._ = {
      persistent-system = {
        dest = mkOption {
          type    = types.str;
          default = "/nix/persistent";
        };
        ephemeral-btrfs = mkOption {  # archive the root subvolume and recreate it empty at every boot
          type    = types.bool;
          default = true;
        };
        dirs = mkOption {
          type    = types.listOf (types.either types.path types.attrs); # attrs: preservation directory submodule, eg. { directory = ...; mode = "0700"; }
          default = [];               # don't add paths here, they will be overwritten
          apply   = unique;           # several aspects may claim the same path
        };
        files = mkOption {
          type    = types.listOf (types.either types.path types.attrs); # attrs: preservation file submodule, eg. { file = ...; inInitrd = true; }
          default = [];
          apply   = unique;
        };
      };

      persistent-home = {
        dest = mkOption {
          type    = types.str;
          default = "/nix/persistent";  # preservation appends /home/<user> itself
        };
        ephemeral-btrfs = mkOption {    # archive the home subvolume and recreate it empty at every boot
          type    = types.bool;
          default = true;
        };
        dirs = mkOption {
          type    = types.listOf (types.either types.str types.attrs); # relative to $HOME, attrs: preservation user directory submodule, eg. { directory = ".ssh"; mode = "0700"; }
          default = [];
          apply   = unique;                  # several aspects may claim the same path
        };
        files = mkOption {
          type    = types.listOf (types.either types.str types.attrs); # attrs: preservation user file submodule, eg. { file = ".config/foo"; mode = "0600"; }
          default = [];
          apply   = unique;
        };
      };
    };
  };
}
