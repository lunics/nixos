{ config, ... }: {
  services.home-manager.autoUpgrade = {
    enable    = false;
    frequency = "Fri *-*-* 21:00:00";
    useFlake  = true;
    flakeDir  = "${config._.flake_dir}#${config._.user}";
  };
}
