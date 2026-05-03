{ config, ... }:let
  _device = config._.disk.device;
in {
  config.disko.devices.disk.${_device} = {
    type   = "disk";
    device = "/dev/${_device}";
    content.type = "gpt";
  };
}
