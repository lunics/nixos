{ config, lib, pkgs, ... }:{ 
  home = {
    packages = with pkgs; [
      (lib.hiPrio taskwarrior3)     # hiPrio needed to avoid conflict with go-task/taskfile
      taskwarrior-tui               # disgusting project, use it only for monitoring
      timewarrior
      taskopen          # script for taking notes and open urls with taskwarrior
      # syncall         ## KO    # bi-directional synchronization between services such as Taskwarrior, Google Calendar, Notion, etc...
      # taskquant py tool
    ];

    file.".config/taskwarrior" = {
      source     = ./taskwarrior;
      recursive  = true;
    };

    file = {
      ".config/taskwarrior/hooks/on-modify_timewarrior.py" = {
        source     = ./hooks/on-modify_timewarrior.py;
        executable = true;
      };
    };

    sessionVariables = rec {
      TASKRC        = "${config._.dot_config}/taskwarrior/taskw/taskrc";
      TASKDATA      = "${config._.share}/taskwarrior";
      TIMEWARRIORDB = "${config._.share}/taskwarrior/timewarrior";    # path for data + config
    };
  };
}
