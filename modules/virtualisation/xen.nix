{
  flake.aspects.xen.nixos = { lib, pkgs, ... }:{
    virtualisation.xen = {
      enable  = lib.mkDefault false;       # BUILD KO qemu-xen-9.2.0: WARNING: '--replace' is deprecated, use --replace-{fail,warn,quiet}
      package = pkgs.xen;

      boot = {
        builderVerbosity = "info"; # handy report of which Xen boot entries were created
        # path = "";
        params = [
          "vga=ask"           # useful for non-headless systems with screens bigger than 640x480
          "dom0=pvh"          # uses the PVH virtualisation mode for Domain 0 instead of PV
          # "iommu=force:true,qinval:true,debug:true"
          # "noreboot=true"
        ];
      };

      dom0Resources = {
        memory    = 1024;   # only allocates 1GiB of memory to Domain 0
        maxMemory = 4096;   # allows Domain 0 to balloon up to 4GiB of memory
        maxVCPUs  = 2;      # allows Domain 0 to use at most two CPU cores
      };

      domains.extraConfig = ''
        XENDOMAINS_SAVE=/persist/xen/save
        XENDOMAINS_RESTORE=false
        XENDOMAINS_CREATE_USLEEP=10000000
      '';

      qemu = {
        package = pkgs.qemu_xen;
        pidFile = "/run/xen/qemu-dom0.pid";
      };

      # store = {
      #   # path = ${config.virtualisation.xen.package}/bin/oxenstored;
      #   settings = {};
      # };

      debug = false;        # debug features for Domain 0
      trace = false;        # debug tracing and logging for Domain 0.
    };
  };
}
