{ pkgs, ... }:{ 
  home.packages = with pkgs; [ rclone ];
  home.file.".config/rclone/rclone.conf".source = ../files/rclone.conf;

  ## https://rclone.org/commands/rclone_mount/
  ## systemctl --user enable --now rclone@iCloud
  ## mounting requires the fusermount or fusermount3 program, rclone will use the fallback PATH of /bin:/usr/bin in this scenario. Please ensure that fusermount/fusermount3 is present on this PATH.
  # systemd.user.services."rclone@.service" = {
  #   Unit = {
  #     Description   = "rclone: Remote FUSE filesystem for cloud storage config %i";
  #     Documentation = "man:rclone(1)";
  #     After         = "network-online.target";
  #     Wants         = "network-online.target";
  #     AssertPathIsDirectory = "%h/mnt/";
  #   };

  #   Service = {
  #     Type         = "notify";
  #     ExecStartPre = "-/usr/bin/mkdir -p %h/mnt/%i";
  #     ExecStart    = ''
  #       ${pkgs.rclone}/bin/rclone mount \
  #       --config=%h/.config/rclone/rclone.conf \
  #       --allow-non-empty \
  #       --vfs-cache-mode writes \
  #       --vfs-cache-max-size 100M \
  #       --dir-cache-time 72h \
  #       --log-level DEBUG \
  #       --log-file /tmp/rclone-%i.log \     ## /tmp in read only
  #       --umask 022 \
  #       --allow-other \
  #       %i: %h/mnt/%i '';
  #     ExecStop = "/bin/fusermount -uz %h/mnt/%i";     ## pkgs.fuse3 ?
  #     ExecStop = "/bin/rmdir %h/cloud/%i";
  #   };

  #   Install.WantedBy  = [ "default.target" ];
  # };
}
