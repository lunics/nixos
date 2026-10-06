{ inputs, ... }:{
  flake-file.inputs.nixvirt = {
    url = "https://flakehub.com/f/AshleyYakeley/NixVirt/*.tar.gz";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  # https://github.com/AshleyYakeley/NixVirt/blob/master/modules.nix
  # https://github.com/AshleyYakeley/NixVirt/tree/master/checks
  flake.aspects = { aspects, ... }:{
    nixvirt = {
      includes = with aspects; [
        kvm
      ];
      nixos = {
        imports = [ inputs.nixvirt.nixosModules.default ];

        virtualisation.libvirt = {
          enable       = true;                # default false, also enables virtualisation.libvirtd
          # package      = pkgs.libvirt;      # KO, default nixvirt's libvirt, mkDefault into virtualisation.libvirtd.package
          verbose      = false;               # useful for figuring out why NixVirt thinks a domain definition has changed
          swtpm.enable = false;               # software TPM emulator, also sets virtualisation.libvirtd.qemu.swtpm

          # keyed by connection URI, each object set is a list or null (null = left untouched)
          connections = {};
          # connections."qemu:///system" = {
          #   # deleting a domain will not delete its volumes, NVRAM, or TPM state
          #   domains = [{
          #     definition = ./domain.xml;    # path to the domain definition XML (virsh dumpxml)
          #     active     = null;            # null = ignore state, true = running, false = stopped
          #     restart    = null;            # null = restart only when changed
          #   }];
          #
          #   networks = [{
          #     definition = ./network.xml;   # virsh net-dumpxml
          #     active     = null;
          #     restart    = null;
          #   }];
          #
          #   # any pool not listed will be deleted
          #   pools = [{
          #     definition = ./pool.xml;      # virsh pool-dumpxml
          #     active     = null;
          #     restart    = null;
          #     # volumes not listed are ignored, https://libvirt.org/formatstorage.html
          #     volumes = [{
          #       present    = true;          # whether the volume should exist
          #       name       = null;          # volume name, needed for present = false
          #       definition = null;          # path to the volume definition XML
          #     }];
          #   }];
          # };
        };
      };
    };
  };
}
