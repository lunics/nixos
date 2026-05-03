{
  virtualisation.spiceUSBRedirection.enable = true;

  options.vfio.enable = with lib; mkEnableOption "Configure the machine for VFIO";

  specialisation."VFIO".configuration = {
    system.nixos.tags = [ "with-vfio" ];
    vfio.enable = true;
  };

  boot.kernelParams = [
    intel_iommu=on
    # "amd_iommu=on"
    iommu=pt
    vfio-pci.ids="8086:51c8"
  ];

  boot.initrd.kernelModules = [
    "vfio_pci"
    "vfio"
    "vfio_iommu_type1"
    "vfio_virqfd"

    "kvm-intel"
  
    # "nvidia"
    # "nvidia_modeset"
    # "nvidia_uvm"
    # "nvidia_drm"
  ];

  boot.blacklistedKernelModules = [ 
    "nvidia" 
    "nouveau" 
  ];

  boot.loader = {
    # Use the systemd-boot EFI boot loader.
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  boot.postBootCommands = ''
    DEVS="0000:0f:00.0 0000:0f:00.1"

    for DEV in $DEVS; do
      echo "vfio-pci" > /sys/bus/pci/devices/$DEV/driver_override
    done
    modprobe -i vfio-pci
 '';


  # If you have more PCIe devices you want to pass through but your iommu rules are not favourable we can patch the NixOS kernel to include the ACS patch which will loosen up the groups and allow us to pass through more devices.
  # nixos-rebuild boot --cores 16       # rebuilding the configuration with all cores
  boot.kernelPackages = pkgs.linuxPackages_latest;
  nixpkgs.config.packageOverrides = pkgs: {
    linux_latest = pkgs.linux_latest.override {
      kernelPatches = pkgs.linux_latest.kernelPatches ++ [
        { name = "acs";
          patch = pkgs.fetchurl {
            url = "https://aur.archlinux.org/cgit/aur.git/plain/add-acs-overrides.patch?h=linux-vfio";
            sha256 = "b90be7b79652be61f7d50691000f6a8c75a240dc2eee2667b68d984f67583f77";
          };
        }
      ];
    };
  };
  kernelParams = [ "amd_iommu=on" "pcie_acs_override=downstream,multifunction" ];

}
