{
  flake.aspects.user-services.homeManager = {
    # whether new or changed services that are wanted by active targets should be started
    # additionally, stop obsolete services from the previous generation
    systemd.user.startServices = "sd-switch";   
      # suggest   or false = shell script to print suggested systemctl commands to run 
      # sd-switch or true  = tool that determines the necessary changes and automatically apply them
  };
}
