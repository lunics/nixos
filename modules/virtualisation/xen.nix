{ lib, pkgs, ... }:{
  virtualisation.xen = {
    enable  = lib.mkDefault false;       # BUILD KO qemu-xen-9.2.0: WARNING: '--replace' is deprecated, use --replace-{fail,warn,quiet}.
    package = pkgs.xen;

    efi = {
      bootBuilderVerbosity = "info"; # Adds a handy report that lets you know which Xen boot entries were created.
      # path = "";
        # ex: ${config.virtualisation.xen.package}/boot/efi/efi/nixos/xen-${config.virtualisation.xen.package.version}.efi
    };

    bootParams = [
      "vga=ask"           # Useful for non-headless systems with screens bigger than 640x480.
      "dom0=pvh"          # Uses the PVH virtualisation mode for the Domain 0, instead of PV.
      # ex: "iommu=force:true,qinval:true,debug:true"
      # ex: "noreboot=true"
    ];

    dom0Resources = {
      memory    = 1024;   # Only allocates 1GiB of memory to the Domain 0, with the rest of the system memory being freely available to other domains.
      maxMemory = 4096;   # Allows the Domain 0 to balloon up to 4GiB of memory.
      maxVCPUs  = 2;      # Allows the Domain 0 to use, at most, two CPU cores.
    };

    domains.extraConfig = ''
      XENDOMAINS_SAVE=/persist/xen/save
      XENDOMAINS_RESTORE=false
      XENDOMAINS_CREATE_USLEEP=10000000
    '';

    qemu = {
      package = pkgs.qemu_xen;
      pidFile = "/run/xen/qemu-dom0.pid";     # ex: "/var/run/xen/qemu-dom0.pid"
    };

    store = {
      # path = ${config.virtualisation.xen.package}/bin/oxenstored;
      settings = {
        
      };
    };

    debug = false;        # debug features for Domain 0
    trace = false;        # debug tracing and logging for Domain 0.
  };
}
