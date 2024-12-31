{
  # TODO https://astro.github.io/microvm.nix/interfaces.html

  microvm = {
    hypervisor = "cloud-hypervisor";
    vcpu = 1;
    mem = 100;  # in MB
    interfaces = [ {  # Network interfaces
      type = "tap";
      id = "vm-a1"; # interface name on the host
      mac = "02:00:00:00:00:01"; # Ethernet address of the MicroVM's interface, not the host's
    } ];
    volumes       # Block device images
    shares        # Shared filesystem directories
    devices       # PCI/USB devices for host-to-vm passthrough
    socket        # Control socket for the Hypervisor
    user          # User account using Qemu 
    forwardPorts  # qemu user-networking only, TCP/UDP port forwarding
    kernelParams  # like boot.kernelParams
    storeOnDisk   # Enables the /nix/store on the boot squashfs
    writableStoreOverlay    # Optional string of the path where all writes to /nix/store should go to
  };
} 
