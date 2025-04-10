{ pkgs, ... }:{ 
  home.packages = with pkgs; [
    taskwarrior3
    taskwarrior-tui
    timewarrior
    taskopen          # script for taking notes and open urls with taskwarrior
    syncall 
    # taskquant py tool
  ];

  mkdir
    ~/.config/taskwarrior/hooks"
    ~/.config/timewarrior
    /home/lunics/usb_copy/homelab/share/taskwarrior
    /home/lunics/usb_copy/homelab/share/timewarrior

  # {{ path_config }}/taskwarrior/taskrc 0644
  # {{ path_config }}/taskwarrior/hooks/on-modify.timewarrior.py 0744
  # {{ path_config }}/timewarrior/timew.cfg
}
