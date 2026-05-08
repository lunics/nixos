{ config, lib, ... }:{
  programs.firefox.profiles.${config._.user}.containers = lib.listToAttrs (
    lib.imap1 (iteration: name: {
      inherit name;
      value = {
        id    = iteration;
        color = "green";
        icon  = "circle";
      };
    }) config._.firefox.containers
  );
}
