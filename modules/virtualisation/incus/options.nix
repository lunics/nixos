{
  flake.aspects.options.generic = { lib, ... }: with lib; {
    options._.incus-vms = mkOption {
      type = types.attrsOf (types.submodule ({ name, ... }:{
        options = {
          name = mkOption {
            type    = types.str;
            default = name;                             # attribute name, also used for the profile and the systemd unit
          };
          # null = not set, checked by an assertion in vm-template.nix
          image = mkOption {
            type    = types.nullOr types.str;
            default = null;                             # e.g. images:nixos/unstable, see incus image list images: nixos
          };
          cpu = mkOption {
            type    = types.nullOr types.ints.positive;
            default = null;
          };
          memory = mkOption {
            type    = types.nullOr types.str;
            default = null;                             # e.g. 4GiB
          };
          disk = mkOption {
            type    = types.nullOr types.str;
            default = null;                             # e.g. 40GiB
          };
          secureboot = mkOption {
            type    = types.bool;
            default = false;                            # the nixos images are not signed
          };
          ip = mkOption {
            type    = types.nullOr types.str;
            default = null;                             # static dhcp lease in the incus-vms subnet, null = dynamic
          };
          hwaddr = mkOption {
            type    = types.nullOr types.str;
            default = null;                             # null = random mac
          };
        };
      }));
      default = {};
      # example = { penguin = { image = "images:nixos/unstable"; cpu = 4; memory = "4GiB"; disk = "40GiB"; }; };
    };
  };
}
