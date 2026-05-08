{ pkgs, ... }:{ 
  programs.nushell.plugins = with pkgs.nushellPlugins; [
    highlight     # syntax highlighting                       KO plugin compiled for v0.108.0, which is not compatible with v0.109.1
    units         # easily converting between common units    KO broken
    query         # to query JSON, XML, and various web data
    net           # list system network interfaces            KO broken
    dbus          # for communicating with D-Bus              KO broken
    desktop_notifications # for sending desktop notifications

    # semver      # to work with semver versions
    # polar       # dataframe plugin commands based on polars
    # formats     # formats plugin
    # gstat       # git status plugin
    # hcl         # parsing HCL files
    # skim        # integrates the skim fuzzy finder
  ];
}
