{ config, lib, ... }:{
  config = lib.mkIf (config._crypttab.text != "") {
    environment.etc.crypttab = {
      enable = true;
      mode   = "0400";
      text   = ''
        # LUKSNAME DEVICE_UUID KEYFILE luks
        ${config._crypttab.text}
      '';
    };
  };
}
