{ lib, ... }: with lib; {
  options._.sudo = {
    wheelNeedsPassword = mkOption {
      type    = types.bool;
      default = true;
    };

    # extraRules = mkOption {
    #   default = [];
    #   type = types.listOf (submodule {
    #     options {
    #       users = mkOption {
    #         type    = with types; listOf (either str int);
    #         default = [];
    #       };

    #       host = mkOption {
    #         type    = types.str;
    #         default = "ALL";
    #       };

    #       runAs = mkOption {
    #         type    = with types; str;
    #         default = "ALL:ALL";
    #       };

    #       # commands = mkOption {
    #       #   type =
    #       #     with types;
    #       #     listOf (
    #       #       either str (submodule {

    #       #         options = {
    #       #           command = mkOption {
    #       #             type = with types; str;
    #       #             description = ''
    #       #               A command being either just a path to a binary to allow any arguments,
    #       #               the full command with arguments pre-set or with `""` used as the argument,
    #       #               not allowing arguments to the command at all.
    #       #             '';
    #       #           };

    #       #           options = mkOption {
    #       #             type =
    #       #               with types;
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
