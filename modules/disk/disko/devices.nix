{ inputs, ... }:{
  flake.aspects.disk.nixos = { config, ... }: let
    _device = config._.disk.device;
  in {
    imports = [ inputs.disko.nixosModules.disko ];

    disko.devices.disk.${_device} = {
      type   = "disk";
      device = "/dev/${_device}";
      content.type = "gpt";
    };
  };
}
