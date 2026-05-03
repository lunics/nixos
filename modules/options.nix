{
  flake.modules.generic.myoptions = { lib, ... }:{
    options.my-hm.git = {
      userName = lib.mkOption {
        type = lib.types.str;
        default = "git-user";
      };

      userEmail = lib.mkOption {
        type = lib.types.str;
        default = "git-user@domaine.com";
      };
    };
  };
}
