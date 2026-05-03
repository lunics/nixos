{ inputs, ... }:{
  flake.modules.nixos.disko = {
    imports = [ inputs.disko.nixosModules.disko ];

    disko.devices.disk.nvme0n1 = {
      type   = "disk";
      device = "/dev/nvme0n1";
      content.type = "gpt";
    };
  };
}
