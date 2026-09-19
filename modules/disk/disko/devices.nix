{ inputs, ... }:{
  flake.aspects.disk.nixos = { config, lib, ... }: let
    _device = config._.disk.device;
  in {
    imports = [ inputs.disko.nixosModules.disko ];

    disko.devices.disk.${_device} = {
      type      = "disk";
      device    = "/dev/${_device}";
      imageSize = lib.mkIf (config._.disk.image-size != null) config._.disk.image-size;
      content.type = "gpt";
    };
  };
}
