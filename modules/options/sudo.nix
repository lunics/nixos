{ lib, ... }:{
  options._sudo = {
    wheelNeedsPassword = lib.mkOption {
      type    = lib.types.bool;
      default = true;
    };

    # extraRules = lib.mkOption {
    #   default = [];
    #   type = lib.types.listOf (submodule {
    #     options {
    #       users = lib.mkOption {
    #         type    = with lib.types; listOf (either str int);
    #         default = [];
    #       };

    #       host = lib.mkOption {
    #         type    = lib.types.str;
    #         default = "ALL";
    #       };

    #       runAs = lib.mkOption {
    #         type    = with lib.types; str;
    #         default = "ALL:ALL";
    #       };

    #       # commands = lib.mkOption {
    #       #   type =
    #       #     with lib.types;
    #       #     listOf (
    #       #       either str (submodule {

    #       #         options = {
    #       #           command = lib.mkOption {
    #       #             type = with lib.types; str;
    #       #             description = ''
    #       #               A command being either just a path to a binary to allow any arguments,
    #       #               the full command with arguments pre-set or with `""` used as the argument,
    #       #               not allowing arguments to the command at all.
    #       #             '';
    #       #           };

    #       #           options = lib.mkOption {
    #       #             type =
    #       #               with lib.types;
    #       #               listOf (enum [
    #       #                 "NOPASSWD"
    #       #                 "PASSWD"
    #       #                 "NOEXEC"
    #       #                 "EXEC"
    #       #                 "SETENV"
    #       #                 "NOSETENV"
    #       #                 "LOG_INPUT"
    #       #                 "NOLOG_INPUT"
    #       #                 "LOG_OUTPUT"
    #       #                 "NOLOG_OUTPUT"
    #       #               ]);
    #       #             description = ''
    #       #               Options for running the command. Refer to the [sudo manual](https://www.sudo.ws/man/1.7.10/sudoers.man.html).
    #       #             '';
    #       #             default = [ ];
    #       #           };
    #       #         };
    #     };
    #   });
    # };
  };
}
