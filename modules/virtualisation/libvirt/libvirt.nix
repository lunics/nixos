{ config, lib, pkgs, ... }:{
  config = lib.mkIf config._libvirt {
    environment.systemPackages = with pkgs; [
      qemu
      quickemu
      # quickgui
      # virt-manager
    ];

    users.users.lunics = {    # enable local user access to libvirt, for example by using virt-manager or gnome-boxes, add yourself to the libvirtd group
      extraGroups = [ "libvirtd" ];
    };

    # programs.virt-manager.enable = true;

    # enable UEFI firmware support in Virt-Manager, Libvirt, etc...
    # systemd.tmpfiles.rules = [ "L+ /var/lib/qemu/firmware - - - - ${pkgs.qemu}/share/qemu/firmware" ];

    virtualisation.libvirtd = {
      enable = true;
      qemu = {
        package =      pkgs.qemu_kvm;
        runAsRoot =    true;
        swtpm.enable = true;
        ovmf = {
          enable = true;
          packages = [(pkgs.OVMF.override {
            secureBoot = true;
            tpmSupport = true;
          }).fd];
        };
      };
    };

    # boot = {
    #   extraModprobeConfig = "options kvm_intel nested=1";   # Nested virtualisation

    #   kernelModules = [ "kvm-amd" "kvm-intel" ];            # enable the relevant KVM kernel, pick only amd if cpu amd host 

    #   binfmt.emulatedSystems = [      # enable the emulation of different architectures
    #     "aarch64-linux"
    #     "riscv64-linux"
    #   ];
    # };

    # ~/.config/libvirt/qemu.conf
    # # Adapted from /var/lib/libvirt/qemu.conf
    # # Note that AAVMF and OVMF are for Aarch64 and x86 respectively
    # nvram = [ "/run/libvirt/nix-ovmf/AAVMF_CODE.fd:/run/libvirt/nix-ovmf/AAVMF_VARS.fd", "/run/libvirt/nix-ovmf/OVMF_CODE.fd:/run/libvirt/nix-ovmf/OVMF_VARS.fd" ]
  };
}
