{ config, lib, inputs, ... }: with lib; {
  # imports = lib.optionals config._.impermanence [ inputs.impermanence.nixosModules.impermanence ];
  imports = [ inputs.impermanence.nixosModules.impermanence ];

  environment.persistence."/persistent" = {
    enable      = config._.impermanence;
    hideMounts  = true;    # hide the bind mounts from showing up as mounted drives in the file manager
    directories = config._.persistent.dirs;
    files       = config._.persistent.files;
  };
}
