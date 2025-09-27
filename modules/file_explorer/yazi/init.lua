require("no-status"):setup()

-- require("yatline"):setup({
-- 	show_background = true,

--   section_separator = { open = "", close = "" },
-- 	part_separator = { open = "", close = "" },
-- 	inverse_separator = { open = "", close = "" },

-- 	header_line = {
-- 		left = {
-- 			section_a = {
-- 			},
-- 			section_b = {
-- 			},
-- 			section_c = {
-- 			}
-- 		},
-- 		right = {
-- 			section_a = {
-- 			},
-- 			section_b = {
-- 			},
-- 			section_c = {
-- 			}
-- 		}
-- 	},
-- 	status_line = {
-- 		left = {
-- 			section_a = {
--         -- {type = "string", custom = false, name = "tab_mode"},
-- 			},
-- 			section_b = {
--         -- {type = "string", custom = false, name = "cursor_percentage"},
-- 			},
-- 			section_c = {
--         -- {type = "string", custom = false, name = "hovered_name"},
-- 			}
-- 		},
-- 		right = {
-- 			section_a = {
--         -- {type = "string", custom = false, name = "cursor_position"},
-- 			},
-- 			section_b = {
--         -- {type = "coloreds", custom = false, name = "permissions"},
-- 			},
-- 			section_c = {
--         -- {type = "string", custom = false, name = "hovered_size"},
--         {type = "string", custom = false, name = ""},
-- 			}
-- 		}
-- 	},
-- })


-- KO
-- require("status"):setup {
--   left  = { "mode", "hovered", "permissions", "owner" },    -- Left side
--   right = { "selection", "size", "mtime", "cwd" },          -- Right side
-- }

-- require("full-border"):setup()

-- Show symlink in status bar
-- Status:children_add(function(self)
-- 	local h = self._current.hovered
-- 	if h and h.link_to then
-- 		return " -> " .. tostring(h.link_to)
-- 	else
-- 		return ""
-- 	end
-- end, 3300, Status.LEFT)

-- Show user/group of files in status bar
-- Status:children_add(function()
-- 	local h = cx.active.current.hovered
-- 	if not h or ya.target_family() ~= "unix" then
-- 		return ""
-- 	end
-- 
-- 	return ui.Line {
-- 		ui.Span(ya.user_name(h.cha.uid) or tostring(h.cha.uid)):fg("magenta"),
-- 		":",
-- 		ui.Span(ya.group_name(h.cha.gid) or tostring(h.cha.gid)):fg("magenta"),
-- 		" ",
-- 	}
-- end, 500, Status.RIGHT)

-- Show username and hostname in header
-- Header:children_add(function()
-- 	if ya.target_family() ~= "unix" then
-- 		return ""
-- 	end
-- 	return ui.Span(ya.user_name() .. "@" .. ya.host_name() .. ":"):fg("blue")
-- end, 500, Header.LEFT)
