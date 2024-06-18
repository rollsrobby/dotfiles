local wezterm = require 'wezterm'
return {
	color_scheme = 'Catppuccin Mocha',
	colors = {
		background = '#1d2021';
	},
	enable_tab_bar = false,
	font_size = 16.0,
	macos_window_background_blur = 30,
	-- window_background_opacity = 0.9,
	window_decorations = 'RESIZE',
	window_close_confirmation = 'NeverPrompt',
	-- window_padding = {
	-- 	left = 0,
	-- 	right = 0,
	-- 	top = 0,
	-- 	bottom = 0,
	-- },
	native_macos_fullscreen_mode = true,
	keys = {
		{
			key = 'n',
			mods = 'SHIFT|CTRL',
			action = wezterm.action.ToggleFullScreen,
		},
	},
	mouse_bindings = {
	  {
	    event = { Up = { streak = 1, button = 'Left' } },
	    mods = 'CTRL',
	    action = wezterm.action.OpenLinkAtMouseCursor,
	  },
	},
}
