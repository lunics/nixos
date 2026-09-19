{
  flake.aspects.raspberry-pi.nixos-raspberrypi = { config, ... }:{
    networking.useNetworkd = true;   # alias of systemd.network.enable, drops dhcpcd and the scripted setup

    # the default 120s hang on a link that never comes up is too long headless
    systemd.network.wait-online.timeout = 30;

    # a rebuild over ssh restarts the link instead of stopping it, for headless board
    systemd.services = {
      systemd-networkd.stopIfChanged = false;
      systemd-resolved.stopIfChanged = false;
    };
  };
}
