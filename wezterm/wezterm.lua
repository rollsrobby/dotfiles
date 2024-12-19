local wezterm = require 'wezterm'
local act = wezterm.action
return {
  color_scheme = "tokyonight",
  front_end = 'WebGpu',
  max_fps = 240,
  font_size = 16.0,
  tab_bar_at_bottom = true,
  keys = {
    {
      key = 'm',
      mods = 'CMD',
      action = act.DisableDefaultAssignment,
    },
    -- {
    --   key = 'j',
    --   mods = 'CMD',
    --   action = act.Multiple {
    --     act.SendKey { key = '\x1b' },
    --     act.SendString ':cnext',
    --     act.SendKey { key = 'Enter' },
    --   },
    -- },
    -- {
    --   key = 'k',
    --   mods = 'CMD',
    --   action = act.Multiple {
    --     act.SendKey { key = '\x1b' },
    --     act.SendString ':cprev',
    --     act.SendKey { key = 'Enter' },
    --   },
    -- },
  },
}
