{ pkgs, ... }:{
  environment.systemPackages = with pkgs; [
    qemu
    virt-manager
  ];

  users.users.lunics = {    # enable local user access to libvirt, for example by using virt-manager or gnome-boxes, add yourself to the libvirtd group
    extraGroups = [ "libvirtd" ];
  };

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

  # boot.extraModprobeConfig = "options kvm_intel nested=1";         # Nested virtualisation

  # ~/.config/libvirt/qemu.conf
  # # Adapted from /var/lib/libvirt/qemu.conf
  # # Note that AAVMF and OVMF are for Aarch64 and x86 respectively
  # nvram = [ "/run/libvirt/nix-ovmf/AAVMF_CODE.fd:/run/libvirt/nix-ovmf/AAVMF_VARS.fd", "/run/libvirt/nix-ovmf/OVMF_CODE.fd:/run/libvirt/nix-ovmf/OVMF_VARS.fd" ]
}
