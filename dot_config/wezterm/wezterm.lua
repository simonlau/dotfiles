-- Pull in the wezterm API
local wezterm = require("wezterm")
local act = wezterm.action

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices

function scheme_for_appearance(appearance)
	if appearance:find("Dark") then
		return "Catppuccin Mocha"
	else
		return "Catppuccin Latte"
	end
end

config.color_scheme = scheme_for_appearance(wezterm.gui.get_appearance())

local tabline = wezterm.plugin.require("https://github.com/michaelbrusegard/tabline.wez")
tabline.setup()
tabline.apply_to_config(config)

local smart_splits = wezterm.plugin.require("https://github.com/mrjones2014/smart-splits.nvim")
smart_splits.apply_to_config(config, {
	-- the default config is here, if you'd like to use the default keys,
	-- you can omit this configuration table parameter and just use
	-- smart_splits.apply_to_config(config)

	-- directional keys to use in order of: left, down, up, right
	-- direction_keys = { "h", "j", "k", "l" },
	-- if you want to use separate direction keys for move vs. resize, you
	-- can also do this:
	direction_keys = {
		move = { "h", "j", "k", "l" },
		resize = { "LeftArrow", "DownArrow", "UpArrow", "RightArrow" },
	},
	-- modifier keys to combine with direction_keys
	modifiers = {
		move = "CTRL", -- modifier to use for pane movement, e.g. CTRL+h to move left
		resize = "META", -- modifier to use for pane resize, e.g. META+h to resize to the left
	},
})

-- config.font = wezterm.font("FiraCode Nerd Font", { weight = "Regular", stretch = "Normal", style = "Normal" })
-- config.font = wezterm.font("IosevkaTerm Nerd Font")
-- config.font = wezterm.font("MonaspiceXe Nerd Font", { weight = "Regular" })
config.font = wezterm.font("Monaspace Xenon Var", { weight = "Regular", stretch = "Normal", style = "Normal" })
config.harfbuzz_features = { "calt", "liga", "ss01", "ss02", "ss03", "ss04", "ss05", "ss06", "ss07", "ss08", "ss09" }
-- config.font = wezterm.font("Monoid Nerd Font", { weight = "Regular", stretch = "SemiCondensed", style = "Normal" })
-- config.harfbuzz_features = { "zero", "cv04", "cv02", "ss05", "ss04" }

config.font_size = 16.0
config.front_end = "WebGpu"
config.window_close_confirmation = "NeverPrompt"
-- config.hide_tab_bar_if_only_one_tab = true

config.window_background_opacity = 0.9
config.macos_window_background_blur = 10

config.keys = {
	{
		key = "K",
		mods = "CTRL|SHIFT",
		action = act.Multiple({
			act.ClearScrollback("ScrollbackAndViewport"),
			act.SendKey({ key = "L", mods = "CTRL" }),
		}),
	},
}
config.leader = { key = "b", mods = "CTRL" }
wezterm.plugin.require("https://github.com/sei40kr/wez-tmux").apply_to_config(config, {})

-- and finally, return the configuration to wezterm
return config
