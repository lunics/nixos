self: super: {
  ssh = super.writeShellApplication {
    name = "ssh";

    runtimeInputs = with super; [
      sshs
      openssh
    ];

    text = ''
      if [ $# -eq 0 ]; then
        sshs
      else
        ssh "$*"
      fi
    '';
  };
}
