# builds the microvm.nix entry of every microvm declared in _.microvm.vms
{ inputs, lib, self, ... }:{
  flake.lib.mvms-template = { name, vm, host }:
  let
    # our own sub-options, microvm.nix would reject them on its own vms option
    sub-options = [ "name" "hypervisor" "memory" "cpu" "balloon" "mac" "ip" "nix-store-shared" "secrets" "credentials" ];

    # microvm.nix entry keys, the vm's own value wins over these
    entry = {
      pkgs             = import inputs.nixpkgs { system = "x86_64-linux"; };
      autostart        = true;
      restartIfChanged = true;
    };

    # taken from the host or from our own sub-options, each vm can still override them
    defaults = {
      time.timeZone       = lib.mkDefault host.time.timeZone;
      system.stateVersion = lib.mkDefault host.system.nixos.release;

      networking.hostName = lib.mkDefault vm.name;

      _.net.addr.ipv4 = lib.mkDefault vm.ip;

      # precondition of the network below, upstream only sets it under optimize.enable
      networking.useNetworkd = lib.mkDefault true;

      # fw_cfg carries the credentials qemu reads from its host unit, the guest systemd imports them
      boot.initrd.kernelModules = lib.optional (vm.credentials != {}) "qemu_fw_cfg";

      # match on the mac, guest interface names vary with the hypervisor, and
      # identify by mac too so the static lease the host reserves for it applies
      systemd.network.networks = lib.mkIf (vm.mac != "" && vm.ip != "") {
        "10-eth" = {
          matchConfig.MACAddress        = lib.mkDefault vm.mac;
          networkConfig.DHCP            = lib.mkDefault "yes";
          dhcpV4Config.ClientIdentifier = lib.mkDefault "mac";
        };
      };

      microvm = {
        hypervisor = lib.mkDefault vm.hypervisor;
        mem        = lib.mkDefault vm.memory;
        vcpu       = lib.mkDefault vm.cpu;
        balloon    = lib.mkDefault vm.balloon;

        credentialFiles = lib.mapAttrs (cred: _: "/run/credentials/microvm@${name}.service/${cred}") vm.credentials;

        # already the upstream defaults, pinned here so the template owns them
        optimize.enable = lib.mkDefault true;
        # null is the off value, the overlay would land on the tmpfs root and eat guest ram
        writableStoreOverlay = lib.mkDefault null;

        # id is the tap name on the host, which its networkd matches as mvm-*
        interfaces = lib.optional (vm.mac != "") {
          type = "tap";
          id   = name;
          mac  = vm.mac;
        };

        # sharing the host store makes microvm.nix skip building a store disk
        shares = lib.optional vm.nix-store-shared {
          tag        = "ro-store";
          source     = "/nix/store";
          mountPoint = "/nix/.ro-store";
          proto      = "virtiofs";
        };
      };
    };

    # an aspect named like the vm has its includes loaded into the guest, not the host,
    # resolved here because modules.nixos skips aspects made only of includes
    aspect = lib.optional (self.aspects ? ${name}) (self.aspects.${name}.resolve { class = "nixos"; });
  in
  entry // (removeAttrs vm sub-options) // {
    config.imports = [
      (vm.config or {})
      self.modules.generic.options
      defaults
    ] ++ aspect;
  };
}
