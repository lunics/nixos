self: super: {
  disk = super.writeShellApplication {
    name = "disk";

    runtimeInputs = with super; [ 
      duf
      dysk
    ];

    text = ''
      duf --hide special
      echo
      dysk
    '';
  };
}
