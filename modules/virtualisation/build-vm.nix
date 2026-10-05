# options from nixos/modules/virtualisation/qemu-vm.nix, only applied by nixos-rebuild build-vm
{
  flake.aspects = {
    options.generic = { config, lib, ... }: with lib; {
      options._.build-vm = {
        memory = mkOption {
          type    = types.ints.positive;
          default = 1024;                             # MiB
        };
        cpu = mkOption {
          type    = types.ints.positive;
          default = 1;
        };
        port = mkOption {
          type    = types.port;
          default = 2222;                             # host port forwarded to the guest ssh
        };
        qcow2-dest = mkOption {
          type        = types.str;
          default     = "./${config.system.name}.qcow2";   # relative to the directory running the vm
          defaultText = literalExpression ''"./''${config.system.name}.qcow2"'';
        };
        persistent = mkOption {
          type    = types.bool;
          default = true;                             # false: tmpfs root, everything lost at shutdown
        };
      };
    };

    build-vm.nixos = { config, lib, pkgs, ... }:
    let
      cfg = config._.build-vm;
    in {
      virtualisation.vmVariant.virtualisation = {
        memorySize        = cfg.memory;               # MiB
        cores             = cfg.cpu;
        msize             = 16384;                    # 9p packet size
        graphics          = true;                     # false: serial console in the terminal
        resolution        = { x = 1024; y = 768; };   # only with grub
        diskImage         = if cfg.persistent
          then lib.mkIf (cfg.qcow2-dest != null) cfg.qcow2-dest   # default ./HOST.qcow2
          else null;                                  # tmpfs root
        emptyDiskImages   = [];                       # [{ size = 1024; driveConfig = {}; }]
        # bootLoaderDevice = "/dev/disk/by-id/virtio-root";
        # bootPartition    = "/dev/disk/by-label/ESP";
        # rootDevice       = "/dev/disk/by-label/nixos";
        # fileSystems      = {};                       # mkForce {} to drop the default ones
        useDefaultFilesystems = true;
        restrictNetwork   = false;                    # no outbound network from the guest
        additionalPaths   = [];                       # store paths copied in the vm store
        useHostCerts      = false;
        host.pkgs         = pkgs;                     # pkgs running qemu, for cross arch vm

        # nix store
        # mountHostNixStore  = true;                   # default: !useNixStoreImage && !useBootLoader
        useNixStoreImage      = false;                # false: host store over 9p, instant start but slow reads
                                                      # true: store image rebuilt at each start, fast reads
        nixStore9pCache       = "loose";              # loose, none, fscache
        # writableStore      = true;                   # default: mountHostNixStore
        writableStoreUseTmpfs = true;

        # boot
        directBoot = {
          # enable = true;                             # default: !useBootLoader
          # initrd = "${config.system.build.initialRamdisk}/initrd";
        };
        useBootLoader     = false;
        # installBootLoader = false;                   # default: useBootLoader && useDefaultFilesystems
        useEFIBoot        = false;
        useBIOSBoot       = false;                    # ignored if useEFIBoot
        bios              = null;                     # pkgs.OVMF.fd, pkgs.seabios
        efi = {
          # firmware      = efi.OVMF.firmware;
          # variables     = efi.OVMF.variables;
          # keepVariables = false;                     # default: useBootLoader
        };
        tpm = {
          enable       = false;                       # swtpm
          # package     = pkgs.swtpm;
          # deviceModel = "tpm-tis";                   # tpm-tis-device on arm
          provisioning = null;
        };

        credentials = {};                             # { name.mechanism = "smbios"; } smbios or fw_cfg

        # shared folders and network
        sharedDirectories = {};                       # { data = { source = "/data"; target = "/mnt/data"; securityModel = "mapped-xattr"; }; }
        forwardPorts      = [{
          from       = "host";
          host.port  = cfg.port;                      # ssh -p 2222 user@localhost
          guest.port = 22;
        }];

        qemu = {
          package            = pkgs.qemu_kvm;         # pkgs.qemu for another arch
          forceAccel         = false;                 # fail instead of falling back to tcg without kvm
          options            = [
            "-device virtio-vga-gl"                   # virtio gpu with virgl 3d acceleration
            "-display gtk,gl=on"                      # local window, "-vnc :0" has no gl
          ];
          # consoles         = [ "ttyS0,115200n8" "tty0" ];
          networkingOptions  = [];
          # drives           = [];
          diskInterface      = "virtio";              # virtio, scsi, ide
          guestAgent.enable  = true;
          virtioKeyboard     = true;
          enableSharedMemory = false;
        };
      };
    };
  };
}
