-- Pull in the wezterm API
local wezterm = require("wezterm")
-- Pull in the mux API
local mux = wezterm.mux
-- This will hold the configuration.
local config = wezterm.config_builder()

-- Disable the system title bar
config.window_decorations = "INTEGRATED_BUTTONS|RESIZE"

-- Set the default font and size
-- config.font = wezterm.font_with_fallback {
--   'JetBrains Mono',
--   'FiraCodeNFM',
-- }
config.font = wezterm.font("JetBrains Mono")
config.font_size = 13.0

-- Set the size of the initial window
config.initial_rows = 35
config.initial_cols = 110

-- Set the color scheme
config.colors = {
	-- The default foreground and background colors ([Shades of Purple] Style)
	foreground = "#fdfdfd",
	background = "#131224",

	-- Default ANSI colors (same colors i used in iterm2)
	ansi = {
		"#24252f", -- Black
		"#ee768c", -- Red
		"#58d8c7", -- Green
		"#ee996d", -- Yellow
		"#7d8cec", -- Blue
		"#bb6ad3", -- Magenta
		"#73e1ef", -- Cyan
		"#fdfdfd", -- White
	},
	brights = {
		"#393c4d", -- Bright Black
		"#fb4566", -- Bright Red
		"#2edec2", -- Bright Green
		"#fc773c", -- Bright Yellow
		"#4b64f7", -- Bright Blue
		"#a43dc4", -- Bright Magenta
		"#42d6e9", -- Bright Cyan
		"#b6b6b9", -- Bright White
	},

	-- Selection color and Cursor color
	-- selection_fg = "#f1d000",
	-- selection_bg = "#add6ff80",
	cursor_border = "#f8cb37",
	cursor_bg = "#f8cb37",
}

-- Make all bold text bright
config.bold_brightens_ansi_colors = true

-- Set the title bar colors
config.window_frame = {
	active_titlebar_bg = "#131224",
	inactive_titlebar_bg = "#131224",
}

-- This function returns the suggested title for a tab.
-- It prefers the title that was set via `tab:set_title()`
-- or `wezterm cli set-tab-title`, but falls back to the
-- title of the active pane in that tab.
local function tab_title(tab_info)
	local title = tab_info.tab_title
	-- if the tab title is explicitly set, take that
	if title and #title > 0 then
		return title
	end
	-- Otherwise, use the title from the active pane
	-- in that tab
	return tab_info.active_pane.title
end

-- This event is triggered when the tab's title changes
wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
	local title = tab_title(tab)
	if tab.is_active then
		return {
			--  Active tab is yellow
			{ Background = { Color = "#131224" } },
			{ Foreground = { Color = "#f8cb37" } },
			{ Text = " " .. title .. " " },
		}
	else
		return {
			-- Inactive tabs are dark
			{ Background = { Color = "#0e0d21" } },
			{ Text = " " .. title .. " " },
		}
	end
end)

-- Set the window initial position in center
wezterm.on("gui-startup", function(cmd) -- set startup Window position
	local screen_info = wezterm.gui.screens().active
	local screen_width = screen_info.width
	local screen_height = screen_info.height
	local window_width = 1792
	local window_height = 1310
	local tab, pane, window = mux.spawn_window(
		cmd or { position = { x = (screen_width - window_width) / 2, y = (screen_height - window_height) / 2 } }
	)
end)

-- FPS for the animation(default is 10)
config.animation_fps = 30
-- Set render engine to WebGpu (nescessary for macos)
config.front_end = "WebGpu"

-- Scrollback lines size
config.scrollback_lines = 50000
-- config.enable_scroll_bar = true

return config
