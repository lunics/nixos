{
  virtualisation.libvirt.connections."qemu:///session".domains = [
    {
      definition = nixvirt.lib.domain.writeXML (nixvirt.lib.domain.templates.linux {
        name   = "Penguin";
        uuid   = "cc7439ed-36af-4696-a6f2-1f0c4474d87e";
        memory = { 
          count = 2; 
          unit = "GiB"; };
        storage_vol = { 
          pool   = "MyPool"; 
          volume = "Penguin.qcow2"; }
      });
    }
  ];
}
