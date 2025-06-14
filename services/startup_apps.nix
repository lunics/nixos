{ pkgs, inputs, ... }:{
  systemd.user = {
    targets."hyprland".Unit.Description = "Hyprland Session Target";

    ## home-manager restart this service at every rebuild
    # services."startup_apps" = {
    #   Unit = {
    #     Description = "Launch desktop applications at Hyprland startup";
    #     After       = [ "hyprland.target"  ];
    #     PartOf      = [ "hyprland.target" ];
    #   };
    #   Service = {
    #     Type = "oneshot";
    #     ExecStart = [ 
    #       # "/bin/sh -c '${pkgs.alacritty}/bin/alacritty &'"    # KO maybe run inside a subshell never displayed
    #       # "${pkgs.alacritty}/bin/alacritty"                   # KO lock the others execstart
    #       "${pkgs.hyprland}/bin/hyprctl dispatch exec mullvad-vpn"
    #       "${pkgs.hyprland}/bin/hyprctl dispatch exec alacritty"
    #       "${pkgs.hyprland}/bin/hyprctl dispatch exec zen-twilight"
    #       "${pkgs.hyprland}/bin/hyprctl dispatch exec udiskie"
    #     ];
    #     Restart   = "on-failure";
    #   };
    #   Install.WantedBy = [ "hyprland.target" ];
    # };
  };
}
