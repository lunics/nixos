{
  flake.aspects.libvirtd.nixos = { config, lib, pkgs, ... }:{
    key = "aspects/libvirtd";         # make the key static so the module system dedups this aspect when included by several others

    environment.systemPackages = with pkgs; [
      qemu
      quickemu
      # quickgui
      # virt-manager
    ];

    users.users.${config._.user}.extraGroups = [ "libvirtd" ];    # enable local user access to libvirt, for example by using virt-manager or gnome-boxes

    # programs.virt-manager.enable = true;

    # enable UEFI firmware support in Virt-Manager, Libvirt, etc
    # systemd.tmpfiles.rules = [ "L+ /var/lib/qemu/firmware - - - - ${pkgs.qemu}/share/qemu/firmware" ];

    virtualisation.libvirtd = {
      enable           = true;
      # package = with pkgs; [ libvirt ];
      onBoot           = "start";       # start, ignore
      onShutdown       = "suspend";     # suspend, shutdown
      parallelShutdown = 0;
      shutdownTimeout  = 300;
      startDelay       = 0;
      allowedBridges   = [ "virbr0" ];
      sshProxy         = true;
      # hooks
      # nss
      # firewallBackend
      qemu = {
        package    = pkgs.qemu_kvm;
        runAsRoot  = true;
        swtpm.enable = true;
        # ovmf = {      # removed, all OVMF images distributed with QEMU are now available by default
        #   enable = true;
        #   packages = [(pkgs.OVMF.override { secureBoot = true; tpmSupport = true; }).fd];
        # };
      };
    };

    # boot = {
    #   extraModprobeConfig = "options kvm_intel nested=1";           # nested virtualisation
    #   binfmt.emulatedSystems = [ "aarch64-linux" "riscv64-linux" ]; # enable the emulation of different architectures
    # };

    # ~/.config/libvirt/qemu.conf
    # # Adapted from /var/lib/libvirt/qemu.conf
    # # Note that AAVMF and OVMF are for Aarch64 and x86 respectively
    # nvram = [ "/run/libvirt/nix-ovmf/AAVMF_CODE.fd:/run/libvirt/nix-ovmf/AAVMF_VARS.fd", "/run/libvirt/nix-ovmf/OVMF_CODE.fd:/run/libvirt/nix-ovmf/OVMF_VARS.fd" ]
  };
}
