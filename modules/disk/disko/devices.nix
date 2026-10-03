{ inputs, ... }:{
  flake.aspects.disk.nixos = { config, lib, ... }: {
    imports = [ inputs.disko.nixosModules.disko ];

    disko.devices.disk.main = {
      type      = "disk";
      device    = config._.disk.device-by-id;
      imageSize = lib.mkIf (config._.disk.image-size != null) config._.disk.image-size;
      content.type = "gpt";
    };
  };
}
