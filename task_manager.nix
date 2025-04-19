{ pkgs, lib, config, ... }:{ 
  home = {
    packages = with pkgs; [
      (lib.hiPrio taskwarrior3)
      taskwarrior-tui
      timewarrior
      taskopen          # script for taking notes and open urls with taskwarrior
      # syncall         ## KO    # bi-directional synchronization between services such as Taskwarrior, Google Calendar, Notion, etc...
      # taskquant py tool
    ];

    file.".config/taskwarrior" = {
      source     = ./files/taskwarrior;
      recursive  = true;
    };

    sessionVariables = rec {
      TASKRC        = "${config.home.homeDirectory}/.config/taskwarrior/taskw/taskrc";
      TASKDATA      = "${config.home.homeDirectory}/usb_copy/homelab/share/taskwarrior";
      TIMEWARRIORDB = "${config.home.homeDirectory}/usb_copy/homelab/share/taskwarrior/timewarrior";    # path for data + config
    };
  };

  # mkdir
  #   ~/.config/taskwarrior/hooks
  #   ~/.config/taskwarrior/hooks/on-modify.timewarrior.py 0744
  #   /home/lunics/usb_copy/homelab/share/timewarrior
}
