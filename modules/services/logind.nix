{
  # Change runtime directory size. automatically systemd managed per-user directory more secure than /tmp
  # limit $XDG_RUNTIME_DIR=/run/user/1000 to 8 GB max; check with: df -h /run/user/1000
  # tmpfs is limited to half of your ram by default, but each tmpfs mounting can be customized
  services.logind.extraConfig = "RuntimeDirectorySize=4G";    # 4G or 10% work
}
