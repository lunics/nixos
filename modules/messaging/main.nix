{
  flake.aspects.messaging.homeManager = { pkgs, ... }:{ 
    home.packages = with pkgs; [
      # SLACK
      # slack               # KO build
      # slackdump           # KO only on FHS compliant OS

      # TELEGRAM
      telegram-desktop
      # materialgram

      ferdium               # franz app like but free
      nchat                 # Terminal-based chat client with support for Telegram and WhatsApp

      # MATRIX
      element-desktop
      # matrix-dl         # download backlogs from Matrix as raw text
      # matrix-hook       # webhook for matrix
    ];
  };
}
