{ pkgs, ... }:{
  programs.tmux.plugins = with pkgs.tmuxPlugins; [ {
    plugin = tmux-floax;
    extraConfig = ''
      # Setting the main key to toggle the floating pane on and off
      set -g @floax-bind '-n M-f'

      # When the pane is toggled, using this bind pops a menu with additional options
      # such as resize, fullscreen, resetting to defaults and more.
      set -g @floax-bind-menu 'P'
      
      # The default width and height of the floating pane
      set -g @floax-width '80%'
      set -g @floax-height '80%'
      
      # The border color can be changed, these are the colors supported by Tmux:
      # black, red, green, yellow, blue, magenta, cyan, white for the standard
      # terminal colors; brightred, brightyellow and so on for the bright variants;
      # colour0/color0 to colour255/color255 for the colors from the 256-color
      # palette; default for the default color; or a hexadecimal RGB color such as #882244.
      set -g @floax-border-color '00af17'
      
      # The text color can also be changed, by default it's blue 
      # to distinguish from the main window
      # Optional colors are as shown above in @floax-border-color
      set -g @floax-text-color 'blue'
      
      # By default when floax sees a change in session path 
      # it'll change the floating pane's path
      # You can disable this by setting it to false
      # You could also "cd -" when the pane is toggled to go back
      set -g @floax-change-path 'true'
      
      # The default session name of the floating pane is 'scratch'
      # You can modify the session name with this option:
      set -g @floax-session-name 'floax-session-name'
      
      # Change the title of the floating window
      set -g @floax-title 'float'
    '';
  } ];
}
