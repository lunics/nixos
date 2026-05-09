{ pkgs, ... }:{ # animate the cursor with a smear effec

  # https://github.com/sphamba/smear-cursor.nvim/

  plugins.smear-cursor.enable = true;

  extraConfigLua = ''
    require("smear_cursor").setup {
      opts = {
        -- Smear cursor color. Defaults to Cursor GUI color if not set.
        -- Set to "none" to match the text color at the target cursor position.
        cursor_color = "#d3cdc3",

        -- Background color. Defaults to Normal GUI background color if not set.
        normal_bg = "#282828",

        -- Smear cursor when switching buffers or windows.
        smear_between_buffers = false,

        -- Smear cursor when moving within line or to neighbor lines.
        smear_between_neighbor_lines = true,

        -- Draw the smear in buffer space instead of screen space when scrolling
        scroll_buffer_space = true,

        -- Set to `true` if your font supports legacy computing symbols (block unicode symbols).
        -- Smears will blend better on all backgrounds.
        -- better at true to draw the smear over a transparent background
        legacy_computing_symbols_support = true,

        -- Smear cursor in insert mode.
        -- See also `vertical_bar_cursor_insert_mode` and `distance_stop_animating_vertical_bar`.
        smear_insert_mode = true,

        stiffness                      = 0.6,
        trailing_stiffness             = 0.45,
        stiffness_insert_mode          = 0.5,
        trailing_stiffness_insert_mode = 0.5,
        damping                        = 0.85,
        damping_insert_mode            = 0.9,
        distance_stop_animating        = 0.1,
        time_interval                  = 17,
      },
    }
  '';
}
