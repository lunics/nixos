{ inputs, ... }:{
  flake.aspects.options.generic = { lib, ... }: with lib; {
    options._ = {
      microvm  = {
        enable = mkEnableOption "";
        sops   = mkEnableOption "";
        vms = mkOption {
          type = types.attrsOf (types.submodule ({ name, ... }:{
            freeformType = types.attrs;     # freeform so the microvm.nix keys (config, autostart, ...) keep passing through
            options = {
              name = mkOption {
                type    = types.str;
                default = name;             # hostname of the guest, the attribute name unless told otherwise
              };
              hypervisor = mkOption {
                type    = types.enum inputs.microvm.lib.hypervisors;
                default = "qemu";           # same default as microvm.hypervisor upstream
              };
              memory = mkOption {
                type    = types.ints.positive;
                default = 512;              # same default as microvm.mem upstream
              };
              cpu = mkOption {
                type    = types.ints.positive;
                default = 1;                # same default as microvm.vcpu upstream
              };
              balloon = mkOption {
                type    = types.bool;
                default = false;            # same default as microvm.balloon upstream
              };
              mac = mkOption {
                type    = types.str;
                default = "";               # empty declares no tap interface at all
              };
              ip = mkOption {
                type    = types.str;
                default = "";               # bare address, fills _.net.addr.ipv4 in the guest
              };
              nix-store-shared = mkOption {
                type    = types.bool;
                default = true;             # false makes microvm.nix build a dedicated store disk
              };
              credentials = mkOption {
                type    = types.attrsOf types.str;
                default = {};               # credential name -> host file, loaded as root by the vm host unit
              };
            };
          }));
          default = {};
        };
      };
    };
  };
}
