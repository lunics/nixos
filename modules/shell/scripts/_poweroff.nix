self: super: {
  _poweroff = super.writeShellApplication {
    name = "_poweroff";

    text = ''
      if which task; then
        export TASKDATA=$HOME/usb_copy/homelab/share/taskwarrior
        export TASKRC=$HOME/.config/taskwarrior/taskw/taskrc

        task +ACTIVE stop || true
      fi

      if systemctl --user restart sync_browser_profile@lunics.service; then
        echo -e "\e[1;32mBrowser saved\e[0m"
      else
        echo -e "\e[1;31mBrowser save failed\e[0m"
        exit
      fi

      if ${super.tmuxPlugins.resurrect}/share/tmux-plugins/resurrect/scripts/save.sh; then
        echo -e "\e[1;32mTmux saved\e[0m"
      else
        echo -e "\e[1;31mTmux save failed\e[0m"
        exit
      fi

      sleep 2

      sudo /run/current-system/sw/bin/poweroff
    '';
  };
}
