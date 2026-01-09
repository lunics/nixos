{ pkgs, ... }:{
  xdg.autostart = {
    enable  = true;
    # entries = [
    #   "${pkgs.evolution}/share/applications/org.gnome.Evolution.desktop"
    # ];
    # readOnly= false;      # readonly directory so that programs cannot install arbitrary autostart services
  };
}
