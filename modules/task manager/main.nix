{
  flake.aspects.task_manager.homeManager = { config, lib, pkgs, ... }:{ 
    home = {
      packages = with pkgs; [
        (lib.hiPrio taskwarrior3)     # hiPrio needed to avoid conflict with go-task/taskfile
        taskwarrior-tui
        timewarrior
        taskopen          # script for taking notes and open urls with taskwarrior
        # syncall         ## KO    # bi-directional synchronization between services such as Taskwarrior, Google Calendar, Notion, etc...
        # taskquant py tool
      ];

      file.".config/taskwarrior" = {
        source     = ./taskwarrior;
        recursive  = true;
      };

      sessionVariables = rec {
        TASKRC        = "${config._.dot_config}/taskwarrior/taskw/taskrc";
        TASKDATA      = "${config._.local_share}/taskwarrior";
        TIMEWARRIORDB = "${config._.local_share}/taskwarrior/timewarrior";    # path for data + config
      };
    };

    _.persistent-home.dirs = [ ".local/share/taskwarrior" ];    # tasks and timewarrior database
  };
}
