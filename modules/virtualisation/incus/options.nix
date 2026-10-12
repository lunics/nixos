{
  flake.aspects.options.generic = { lib, ... }: with lib; {
    options._.incus-vms = mkOption {
      type = types.attrsOf (types.submodule ({ name, ... }:{
        options = {
          name = mkOption {
            type    = types.str;
            default = name;                             # attribute name, also used for the profile and the systemd unit
          };
          image = mkOption {
            type    = types.str;
            default = "images:nixos/unstable";          # incus image list images: nixos
          };
          cpu = mkOption {
            type    = types.ints.positive;
            default = 4;
          };
          memory = mkOption {
            type    = types.str;
            default = "4GiB";
          };
          disk = mkOption {
            type    = types.str;
            default = "40GiB";
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
      # example = { penguin = { cpu = 2; ip = "10.0.100.10"; }; puffin = { memory = "8GiB"; }; };
    };
  };
}
