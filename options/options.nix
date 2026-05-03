{
  flake.modules.generic.myoptions = { lib, ... }: with lib; {
    options._.git = {
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
