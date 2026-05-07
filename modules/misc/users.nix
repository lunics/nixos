{
  flake.aspects.users.nixos = { pkgs, ... }:{
    users.users.lunics = {
      isNormalUser = true;
      shell = pkgs.bash;
      extraGroups = [ "wheel" ];
      hashedPassword = "$6$0IvSyfu91e4tjIJs$79VmwUQ3VpFtZZVJwUYDyOdCM6MqoF13zs55tCEL4HggKDhH0KgSbgjjZVg/4DhjWbW0kYMY5QXNWFn/JOQbp0";
    };
  };
}
