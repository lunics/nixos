{
  # https://github.com/rcarriga/nvim-notify

  plugins.notify.enable = true;

  extraConfigLua = ''
    require("notify").setup {
      stages            = "fade",     -- fade, slide, fade_in_slide_out, static
      timeout           = 3000,       -- time it stays on screen in millisec
      render            = "default",  -- default, minimal, simple, compact
      max_width         = 50,         -- max width window
      fps               = 60,         -- frequency of the animation (higher is smoother)
      level             = 2,
      top_down          = true,
      minimum_width     = 50,
      background_colour = "NotifyBackground",
      icons = {
        DEBUG = "",
        ERROR = "",
        INFO = "",
        TRACE = "✎",
        WARN = ""
      },
      time_formats = {
        notification = "%T",
        notification_history = "%FT%T"
      },
    }
  '';
}
