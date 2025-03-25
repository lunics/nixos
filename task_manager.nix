{ pkgs, ... }:{ 
  home.packages = with pkgs; [
    taskwarrior3
    timewarrior
    taskwarrior-tui
    taskopen          # script for taking notes and open urls with taskwarrior
    syncall ];


  mkdir
    "{{ path_config }}/taskwarrior/hooks"
    "{{ path_share_cloud }}/taskwarrior"

  - name: taskwarrior | template > generate taskwarrior config file and timew hook
    template:
      src:  "{{ item.src  }}"
      dest: "{{ item.dest }}"
      mode: "{{ item.mode }}"
    loop:
      - { src: taskrc,
          dest: "{{ path_config }}/taskwarrior/taskrc",
          mode: "0644" }
      - { src: on-modify.timewarrior.py,
          dest: "{{ path_config }}/taskwarrior/hooks/on-modify.timewarrior.py",
          mode: "0744" }
}
