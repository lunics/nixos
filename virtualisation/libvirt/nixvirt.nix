{ pkgs, ... }:{
  # https://github.com/AshleyYakeley/NixVirt/tree/master/checks

  # imports = [
  #   ./nixvirt_vm_linux.nix
  # ];

  virtualisation.libvirt = {
    enable       = true;
    # package      = pkgs.libvirt;  # KO
    verbose      = false;           # useful for figuring out why NixVirt thinks a domain definition has changed
    swtpm.enable = false;           # software TPM emulator

    # connections."qemu:///system" = {
    #   # Deleting a domain will not delete its volumes, NVRAM, or TPM state
    #   domains = {
    #     # definition = path;    # local path to an domain definition XML (virsh dumpxml)
    #     # active = true;
    #     # restart = true;
    #   };

    #   networks = {
    #     # definition = path;    # local path to an domain definition XML (virsh net-dumpxml)
    #     # active = true;
    #     # restart = true;
    #   };

    #   # any libvirt pool not defined in the list will be deleted
    #   pools = {
    #     # definition = path;    # local path to an domain definition XML (virsh pool-dumpxml)
    #     # active = true;
    #     # restart = true; volumes = [   # Existing volumes not listed will be ignored and not deleted 
    #                   # https://libvirt.org/formatstorage.html
    #       name = "VOLUMENAME";
    #       present = true;
    #       # definition = path;    # local path to an domain definition XML (virsh pool-dumpxml)
    #     };
    #   };
    # };
  };
}
