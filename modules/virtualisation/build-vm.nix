# options from nixos/modules/virtualisation/qemu-vm.nix, only applied by nixos-rebuild build-vm
{
  flake.aspects.build-vm.nixos = {
    virtualisation.vmVariant.virtualisation = {
      memorySize        = 1024;                     # MiB
      cores             = 1;
      msize             = 16384;                    # 9p packet size
      graphics          = true;                     # false: serial console in the terminal
      resolution        = { x = 1024; y = 768; };   # only with grub
      # diskImage        = "./HOST.qcow2";           # null: tmpfs root
      emptyDiskImages   = [];                       # [{ size = 1024; driveConfig = {}; }]
      # bootLoaderDevice = "/dev/disk/by-id/virtio-root";
      # bootPartition    = "/dev/disk/by-label/ESP";
      # rootDevice       = "/dev/disk/by-label/nixos";
      # fileSystems      = {};                       # mkForce {} to drop the default ones
      useDefaultFilesystems = true;
      restrictNetwork   = false;                    # no outbound network from the guest
      additionalPaths   = [];                       # store paths copied in the vm store
      useHostCerts      = false;
      # host.pkgs        = pkgs;                     # pkgs running qemu, for cross arch vm

      # nix store
      # mountHostNixStore  = true;                   # default: !useNixStoreImage && !useBootLoader
      useNixStoreImage      = false;
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
      forwardPorts      = [];                       # [{ from = "host"; host.port = 2222; guest.port = 22; }]

      qemu = {
        # package          = pkgs.qemu_kvm;          # pkgs.qemu for another arch
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
}
